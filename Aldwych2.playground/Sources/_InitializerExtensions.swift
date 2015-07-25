import Foundation

// MARK: Initializers
extension JSONValue {
    public init (_ num:NSNumber) {
        self = .Number(num)
    }
    
    public init (_ str:String) {
        self = .JString(str)
    }
    public init (_ val:NSNull) {
        self = .Null
    }
    public init (_ bool:Bool) {
        self = .JBool(bool)
    }
    public init (_ arr:[JSONValue]) {
        self = .JArray(arr)
    }
    
    public init (_ dict:[String:JSONValue]) {
        self = .JDictionary(dict)
    }
}


// MARK: AnyObject handlers
extension JSONValue {
    public init (value:AnyObject) {
        
        if let a = value as? String {
            self = .JString(a)
        }
        else if let a = value as? NSNumber {
            if a.isBoolNumber() {
                self = .JBool(a.boolValue)
            }
            else {
                self = .Number(a)
            }
        }
        else if let _ = value as? NSNull {
            self = .Null
        }
        else if let a = value as? [AnyObject] {
            self = JSONValue(array:a)
        }
        else if let a = value as? [String:AnyObject] {
            self = JSONValue(dictionary:a)
        }
        else {
            self = .Null
        }
        
    }
    
    public init (array:[AnyObject]) {
        self = JSONValue(array.map{JSONValue(value:$0)})
    }
    public init (dictionary:[String: AnyObject]) {
        let initial = [String: JSONValue]()
        self = JSONValue(dictionary.reduce(initial, combine: { (var dict, val) in
            dict[val.0] = JSONValue(value:val.1)
            return dict
        }))
    }
}