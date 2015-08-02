import Foundation
extension JSONDictionary:Equatable {}
public func ==(lhs: JSONDictionary, rhs: JSONDictionary) -> Bool {
    
            for (k,_) in lhs {
                if lhs[k] != rhs[k] {
                    return false
                }
            }
            for (k,_) in rhs {
                if lhs[k] != rhs[k] {
                    return false
                }
            }
            return true
    

}
public func ==(lhs: JSONDictionary, rhs: JSONValue) -> Bool {
 
    for (k,_) in lhs {
        if lhs[k] != rhs[k] {
            return false
        }
    }
    for (k,_) in rhs {
        if lhs[k] != rhs[k] {
            return false
        }
    }
    return true
    
    
}

public enum JSONDictionary:JSONObjectType {
    case JDictionary([String:JSONValue])
}
extension JSONDictionary {
    public init (dictionary:[String: AnyObject]) {
        let initial = [String: JSONValue]()
        self = JSONDictionary.JDictionary(dictionary.reduce(initial, combine: { (var dict, val) in
            dict[val.0] = JSONValue(value:val.1)
            return dict
        }))
    }
}

extension JSONDictionary {
    public var dictionary:Swift.Dictionary<String,AnyObject> {
        var dictionary = Swift.Dictionary<String,AnyObject>()
        
        switch self {
        case .JDictionary (let dict):
            for (k,v) in dict {
                if let a: AnyObject = v.str ?? v.num ?? v.bool ?? v.null {
                    dictionary[k] = a
                }
                else if v.jsonArray != nil {
                    dictionary[k] = v.array as AnyObject
                }
                else if v.jsonDictionary != nil {
                    dictionary[k] = v.dictionary as AnyObject
                }
            }
        }
        return dictionary
    }
    
    public var nsDictionary:NSDictionary {
        let dictionary = NSMutableDictionary()
        
        switch self {
        case .JDictionary (let dict):
            for (k,v) in dict {
                if let a: AnyObject = v.str ?? v.num ?? v.bool ?? v.null {
                    dictionary[k] = a
                }
                else if v.jsonArray != nil {
                    dictionary[k] = v.array as NSArray
                }
                else if v.jsonDictionary != nil {
                    dictionary[k] = v.dictionary as NSDictionary
                }
            }
        }
        return dictionary
    }
    
}

extension JSONDictionary {
    public mutating func updateValue(value:JSONValue, forKey key:String) {
        switch self {
        case .JDictionary(var dictionary):
            dictionary.updateValue(value, forKey: key)
            self = .JDictionary(dictionary)
        }
    }
    enum JSONTypeError:ErrorType {
        case TypeError(String)
    }
    public mutating func updateValue(value:AnyObject, forKey key:String, typesafe:TypeSafety) {
        switch self {
        case .JDictionary(var dictionary):
            if case .Unsafe = typesafe {
                dictionary[key] = JSONValue(value:value)
                self = .JDictionary(dictionary)
                break
            }
            else if dictionary[key]?.null != nil  {
                dictionary[key] = JSONValue(value:value)
                self = .JDictionary(dictionary)
                break
            }
            guard let dV = dictionary[key] else {
                // dictionary key currently has no associated value
                dictionary[key] = JSONValue(value:value)
                self = .JDictionary(dictionary)
                break
            }
            
            dictionary[key] = typesafeReplace(dV, value: value)
            self = .JDictionary(dictionary)
        }
    }
    
    public mutating func nullValueForKey(key:String) {
        // this should never ever fail
         updateValue(NSNull(), forKey: key, typesafe: .Unsafe)
    }
}


extension JSONDictionary {
    public subscript (key:String) -> JSONValue? {
        get {
            switch self {
            case .JDictionary(let a):
                return a[key]
       
            }}
        set(newValue) {
            
            switch self {
            case .JDictionary(var a):
                if let nV = newValue {
                    a[key] = nV
                    self = .JDictionary(a)
                }
            }}
    }
    
    public subscript (key:String) -> AnyObject? {
        get {
            return nil
        }
        set(newValue) {
            
            switch self {
            case .JDictionary(var a):
                if let nV = newValue {
                    a[key] = JSONValue(value:nV)
                    self = .JDictionary(a)
                }
         
            }}
    }
    
    public subscript (key:String, typesafe:TypeSafety) -> AnyObject? {
        get {
            return nil
        }
        set(newValue) {
            
            switch self {
            case .JDictionary(var a):
                guard let nV = newValue else {
                    fatalError("No value to insert into array")
                }
                guard let dV = a[key] else {
                    // no current key, so add
                    a[key] = JSONValue(value:nV)
                    self = .JDictionary(a)
                    break
                }
                if case .Unsafe = typesafe {
                    a[key] = JSONValue(value:nV)
                    self = .JDictionary(a)
                }
                else if case .Typesafe = typesafe {
                    a[key] = typesafeReplace(dV, value:nV)
                    self = .JDictionary(a)
                }
 
                
            }}
    }

    
}


extension JSONDictionary: SequenceType  {
    
    public typealias Generator  = JSONDictionaryGenerator
    
    public func generate() -> Generator {
        let gen = Generator(value: self)
        return gen
    }
}

// FIXME: Necessary to repeat generator for JSONValue.JDictionary and JSONDictionary?
// Dictionary Generator
public struct JSONDictionaryGenerator:GeneratorType {
    // use dictionary with index as keys for position in array
    let value:JSONDictionary
    var indexInSequence:Int = 0
    
    init(value:JSONDictionary) {
        self.value = value
        
    }
    
    mutating public func next() -> (String,JSONValue)? {
        switch value {
        case .JDictionary (let dictionary):
            let keyArray = [String](dictionary.keys)
            if indexInSequence < dictionary.count
            {   let key = keyArray[indexInSequence]
                let element = dictionary[key]
                ++indexInSequence
                return (key,element!)
            }
            else {
                indexInSequence = 0
                return nil
            }
        }
    }
}
