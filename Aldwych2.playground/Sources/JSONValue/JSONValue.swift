import Foundation


// MARK: Core enum
public enum JSONValue {
    
    case JString(String), Number(NSNumber), JBool(Bool), Null
    indirect case JArray([JSONValue]), JDictionary([String:JSONValue])
    
}


// MARK: Extract inner value
extension JSONValue {
    
    public var str:String? {
        switch self {
        case .JString(let str):
            return str
        default:
            return nil
        }
        
    }
    public var strOpt:String?? {
        switch self {
        case .JString(let str):
            return str
        case .Null:
            let a:String? = nil
            return a
        default:
            return nil
        }
        
    }
    
    
    public var num:NSNumber? {
        switch self {
        case .Number(let num):
            return num
        default:
            return nil
        }
        
    }
    public var numOpt:NSNumber?? {
        switch self {
        case .Number(let num):
            return num
        case .Null:
            let a:NSNumber? = nil
            return a
        default:
            return nil
        }
        
    }
    
    public var bool:Bool? {
        switch self {
        case .JBool(let bool):
            return bool
        default:
            return nil
        }
        
    }
    public var boolOpt:Bool?? {
        switch self {
        case .JBool(let bool):
            return bool
        case .Null:
            let a:Bool? = nil
            return a
        default:
            return nil
        }
        
    }
    public var null:NSNull? {
        switch self {
        case .Null:
            return NSNull()
        default:
            return nil
        }
        
    }
    
    public  var jsonArray:JSONArray? {
        switch self {
        case .JArray(let jsonArr):
            return JSONArray.JArray(jsonArr)
        default:
            return nil
        }
        
    }
    public var jsonArrayOpt:JSONArray?? {
        switch self {
        case .JArray(let jsonArr):
            return JSONArray.JArray(jsonArr)
        case .Null:
            let a:JSONArray? = nil
            return a
        default:
            return nil
        }
        
    }
    public var jsonDictionary:JSONDictionary? {
        switch self {
        case .JDictionary(let jsonDict):
            return JSONDictionary.JDictionary(jsonDict)
        default:
            return nil
        }
        
    }
    
    public var jsonDictionaryOpt:JSONDictionary?? {
        switch self {
        case .JDictionary(let jsonDict):
            return JSONDictionary.JDictionary(jsonDict)
        case .Null:
            let a:JSONDictionary? = nil
            return a
        default:
            return nil
        }
        
    }
    
    
}

extension JSONValue {
    public var count:Int {
        switch self {
        case .JArray(let arr):
            return arr.count
        default:
           return 0
        }
        
    }
    public var last:JSONValue? {
        switch self {
        case .JArray(let arr):
            return arr.last
        default:
            return nil
        }
        
    }
}

extension JSONValue:CustomStringConvertible {

    public var description:String {
        
        switch self {
        case .JDictionary( _):
            return Swift.String(self.dictionary)
        case .JArray( _):
            return Swift.String(self.array)
        case .JBool(let b):
            if b == true {
                return "true"
            }
            else {
                return "false"
            }
        case .Number(let n):
            return Swift.String(n)
        case .JString(let s):
            return "\"\(s)\""
        default:
            return "JSONValue"
        }
        
        }
    


}

public extension JSONValue {
    public func isJSONBool () -> Bool {
        return self.bool != nil
    }
    public func isJSONNull () -> Bool {
        return self.null != nil
    }
    public func isJSONNumber () -> Bool {
        return self.num != nil
    }
    public func isJSONString () -> Bool {
        return self.str != nil
    }
    
    public func isJSONDictionary () -> Bool {
        return self.jsonDictionary != nil
    }
    public func isJSONArray () -> Bool {
        return self.jsonDictionary != nil
    }
    public func canReplaceWithBool() -> Bool {
        if self.isJSONBool() || self.isJSONNull() {
            return true
        }
        return false
    }
    public func canReplaceWithNumber() -> Bool {
        if self.isJSONNumber() || self.isJSONNull() {
            return true
        }
        return false
    }
    public func canReplaceWithString() -> Bool {
        if self.isJSONString() || self.isJSONNull() {
            return true
        }
        return false
    }
    public func canReplaceWithArray() -> Bool {
        if self.isJSONArray() || self.isJSONNull() {
            return true
        }
        return false
    }

    public func canReplaceWithDictionary() -> Bool {
        if self.isJSONDictionary() || self.isJSONNull() {
            return true
        }
        return false
    }

    
}






