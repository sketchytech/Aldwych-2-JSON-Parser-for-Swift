import Foundation
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
    public mutating func updateValue(value:AnyObject, forKey key:String, typesafe:Bool = true) throws {
        switch self {
        case .JDictionary(var dictionary):
            if typesafe == false || dictionary[key]?.null != nil || dictionary[key] == nil {
                dictionary[key] = JSONValue(value:value)
                self = .JDictionary(dictionary)
            }
            else if dictionary[key]?.str != nil && value as? String != nil {
                dictionary[key] = JSONValue(value:value)
                self = .JDictionary(dictionary)
            }
            else if dictionary[key]?.bool != nil && value as? NSNumber != nil  {
                if ((value as? NSNumber)?.isBoolNumber() == true) {
                    dictionary[key] = JSONValue(value:value)
                    self = .JDictionary(dictionary)
                }
                else {
                    throw JSONError.TypeError("Attempt to replace bool with number in typesafe mode")
                }
            }
            else if dictionary[key]?.num != nil && value as? NSNumber != nil {
                if ((value as? NSNumber)?.isBoolNumber() == false) {
                    dictionary[key] = JSONValue(value:value)
                    self = .JDictionary(dictionary)
                }
                else {
                    throw JSONError.TypeError("Attempt to replace number with bool in typesafe mode")
                }
            }
            else if dictionary[key]?.jsonArray != nil && value as? [AnyObject] != nil {
                dictionary[key] = JSONValue(value:value)
                self = .JDictionary(dictionary)
            }
            else if dictionary[key]?.jsonDictionary != nil && value as? [String:AnyObject] != nil {
                dictionary[key] = JSONValue(value:value)
                self = .JDictionary(dictionary)
            }
            else {
                throw JSONError.TypeError("Type is not JSON compatible")
            }
        }
    }
    
    public mutating func nullValueForKey(key:String) {
        // this should never ever fail
        try! updateValue(NSNull(), forKey: key, typesafe: false)
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
