import Foundation


// MARK: Extract dictionary
extension JSONValue {
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
        default:
            break
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
        default:
            break
        }
        return dictionary
    }
    
}

// Dictionary subscripting
extension JSONValue {
   

    public subscript (key:String) -> JSONValue? {
        get {
            switch self {
            case .JDictionary(let a):
                return a[key]
                
            default:
                
                return nil
            }}
        set(newValue) {
            
            switch self {
            case .JDictionary(var a):
                if let nV = newValue {
                    a[key] = nV
                    self = .JDictionary(a)
                }
            default:
                return
            }}
    }

    public subscript (key:String) -> String? {
        get {
            switch self {
            case .JDictionary(let a):
                if let s = a[key]?.str {
                    return s
                }
                else {return nil}
                
            default:
                
                return nil
            }}
        set(newValue) {
            
            switch self {
            case .JDictionary(var a):
                if let nV = newValue {
                    a[key] = .JString(nV)
                    self = .JDictionary(a)
                }
            default:
                return
            }}
    }
    
    public subscript (key:String) -> NSNumber? {
        get {
            switch self {
            case .JDictionary(let a):
                if let n = a[key]?.num {
                    return n
                }
                else {return nil}
                
            default:
                
                return nil
            }}
        set(newValue) {
            
            switch self {
            case .JDictionary(var a):
                if let nV = newValue {
                    a[key] = .Number(nV)
                    self = .JDictionary(a)
                }
            default:
                return
            }}
    }
    public subscript (key:String) -> Bool? {
        get {
            switch self {
            case .JDictionary(let a):
                if let b = a[key]?.bool {
                    return b
                }
                else {return nil}
                
            default:
                
                return nil
            }}
        set(newValue) {
            
            switch self {
            case .JDictionary(var a):
                if let nV = newValue {
                    a[key] = .JBool(nV)
                    self = .JDictionary(a)
                }
            default:
                return
            }}
    }
    public subscript (key:String) -> NSNull? {
        get {
            switch self {
            case .JDictionary(let a):
                if let n = a[key]?.null {
                    return n
                }
                else {return nil}
                
            default:
                
                return nil
            }}
        set(newValue) {
            
            switch self {
            case .JDictionary(var a):
                if let _ = newValue {
                    a[key] = .Null
                    self = .JDictionary(a)
                }
            default:
                return
            }}
    }
}


// MARK: Keys and Values
extension JSONValue {
    public var keys:[String] {
        switch self {
        case .JDictionary(let dict):
            return [String](dict.keys)
        default:
            return []
            }
     
    }
    public var values:[JSONValue] {
        switch self {
        case .JDictionary(let dict):
            return [JSONValue](dict.values)
        default:
            return []
        }
        
    }
}

