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
    public mutating func updateValue(value:AnyObject, forKey key:String) {
        switch self {
        case .JDictionary(var dictionary):
            dictionary.updateValue(JSONValue(value: value), forKey: key)
            self = .JDictionary(dictionary)
        }
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
// MARK: Extract inner value
extension JSONDictionary {
     public var jsonDict:[String:JSONValue]? {
        switch self {
        case .JDictionary(let jsonDict):
            return jsonDict
        }
    }
    public var jsonDictOpt:[String:JSONValue]?? {
        switch self {
        case .JDictionary(let jsonDict):
            return jsonDict
        }
    }
}

extension JSONDictionary: SequenceType  {
    
    public typealias Generator  = JSONDictionaryGenerator
    
    public func generate() -> Generator {
        let gen = Generator(value: self)
        return gen
    }
}
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
