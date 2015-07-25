import Foundation

extension JSONValue:Equatable {}
public func ==(lhs: JSONValue, rhs: JSONValue) -> Bool {
    // FIXME: build equality method
    return false
}

// MARK: Core enum
public enum JSONValue {
    
    case JString(String), Number(NSNumber), JBool(Bool), Null
    indirect case JArray([JSONValue]), JDictionary([String:JSONValue])
    
}

extension JSONValue {
    

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
    
    public  var jsonArr:[JSONValue]? {
        switch self {
        case .JArray(let jsonArr):
            return jsonArr
        default:
            return nil
        }
        
    }
    public var jsonArrOpt:[JSONValue]?? {
        switch self {
        case .JArray(let jsonArr):
            return jsonArr
        case .Null:
            let a:[JSONValue]? = nil
            return a
        default:
            return nil
        }
        
    }
    public var jsonDict:[String:JSONValue]? {
        switch self {
        case .JDictionary(let jsonDict):
            return jsonDict
        default:
            return nil
        }
        
    }
    
    public var jsonDictOpt:[String:JSONValue]?? {
        switch self {
        case .JDictionary(let jsonDict):
            return jsonDict
        case .Null:
            let a:[String:JSONValue]? = nil
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



