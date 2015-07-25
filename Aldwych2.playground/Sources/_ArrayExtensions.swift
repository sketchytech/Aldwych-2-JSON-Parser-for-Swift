import Foundation

// MARK: Extract Array
extension JSONValue {
    public var array:[AnyObject] {
        var array = [AnyObject](count: self.count, repeatedValue: 0)
        switch self {
        case .JArray(let arr):
            for v in arr.enumerate() {
                if let a: AnyObject = v.1.str ?? v.1.num ?? v.1.bool ?? v.1.null {
                    array[v.0] = a
                }
                else if v.1.jsonDict != nil {
                    array[v.0] = v.1.dictionary as AnyObject
                }
                else if v.1.jsonArr != nil {
                    array[v.0] = v.1.array as AnyObject
                }
            }
        default:
            break
        }
        return array
    }
    
    public var nsArray:NSArray {
        
        let array = NSMutableArray(capacity: self.count)
        switch self {
        case .JArray(let arr):
            for v in arr {
                if let s: NSString = v.str {
                    array.addObject(s)
                }
                if let n: NSNumber = v.num {
                    array.addObject(n)
                }
                if let b: Bool = v.bool {
                    array.addObject(b)
                }
                if let n: NSNull = v.null {
                    array.addObject(n)
                }
                else if v.jsonDict != nil {
                    array.addObject(v.nsDictionary)
                }
                else if v.jsonArr != nil {
                    array.addObject(v.nsArray)
                }
            }
        default:
            break
        }
        return array
    }
}

// subscripting Arrays
extension JSONValue {
    
    public subscript (key:Int) -> JSONValue? {
        get {
            switch self {
            case .JArray (let a):
                if key >= a.endIndex {
                    return nil
                }
                return a[key]
                
            default:
                return nil
            }}
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    
                }
                else if let nV = newValue {
                    a[key] = nV
                    self = .JArray(a)
                }
            default:
                return
            }}
    }
    
    
    public subscript (key:Int) -> Swift.String? {
        get {
            switch self {
            case .JArray (let a):
                if key >= a.endIndex {
                    return nil
                }
                else if let s = a[key].str {
                    return s
                }
                else {return nil}
            default:
                return nil
            }}
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    
                }
                else if let nV = newValue {
                    a[key] = .JString(nV)
                    self = .JArray(a)
                }
            default:
                return
            }}
    }
    
    public subscript (key:Int) -> NSNumber? {
        get {
            switch self {
            case .JArray (let a):
                if key >= a.endIndex {
                    return nil
                }
                else if let n = a[key].num {
                    return n
                }
                else {return nil}
            default:
                return nil
            }}
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    
                }
                else if let nV = newValue {
                    a[key] = .Number(nV)
                    self = .JArray(a)
                }
            default:
                return
            }}
    }
    public subscript (key:Int) -> Bool? {
        get {
            switch self {
            case .JArray (let a):
                if key >= a.endIndex {
                    return nil
                }
                else if let b = a[key].bool {
                    return b
                }
                else {return nil}
            default:
                return nil
            }}
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    
                }
                else if let nV = newValue {
                    a[key] = .JBool(nV)
                    self = .JArray(a)
                }
            default:
                return
            }}
    }
    
    public subscript (key:Int) -> NSNull? {
        get {
            switch self {
            case .JArray (let a):
                if key >= a.endIndex {
                    return nil
                }
                else if let b = a[key].null {
                    return b
                }
                else {return nil}
            default:
                return nil
            }}
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    
                }
                else if let _ = newValue {
                    a[key] = .Null
                    self = .JArray(a)
                }
            default:
                return
            }}
    }
}


// MARK: Append methods
extension JSONValue {
    // Append method
    public mutating func append(str:String) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(str))
            self = JSONValue.JArray(array)
        default:
            return
            }
        }
    
    public mutating func append(num:NSNumber) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(num))
            self = JSONValue.JArray(array)
        default:
            return
        }
}
    public mutating func append(bool:Bool) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(bool))
            self = JSONValue.JArray(array)
        default:
            return
        }
        
    }
    
    public mutating func append(null:NSNull) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(null))
            self = JSONValue.JArray(array)
        default:
            return
        }
    }
    
    public mutating func append(dict:[String:AnyObject]) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(dictionary: dict))
            self = JSONValue.JArray(array)
        default:
            return
        }
    }
    
    public mutating func append(arr:[AnyObject]) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(array:arr))
            self = JSONValue.JArray(array)
        default:
            return
        }
    }
    
    public mutating func append(arr:JSONValue) {
        switch self {
        case .JArray(var array):
            array.append(arr)
            self = JSONValue.JArray(array)
        default:
            return
        }
    }
    
}

// MARK: Insert methods
extension JSONValue {
public mutating func insert(str:Swift.String, atIndex ind:Int) {
    switch self {
    case .JArray(var array):
        array.insert(JSONValue(str), atIndex: ind)
        self = JSONValue.JArray(array)
    default:
        return
    }
}
public mutating func insert(num:NSNumber, atIndex ind:Int) {
    switch self {
    case .JArray(var array):
        array.insert(JSONValue(num), atIndex: ind)
        self = JSONValue.JArray(array)
    default:
        return
    }
    }

public mutating func insert(bool:Bool, atIndex ind:Int) {
    switch self {
    case .JArray(var array):
        array.insert(JSONValue(bool), atIndex: ind)
        self = JSONValue.JArray(array)
    default:
        return
    }
}

public mutating func insert(null:NSNull, atIndex ind:Int) {
    switch self {
    case .JArray(var array):
        array.insert(JSONValue(null), atIndex: ind)
        self = JSONValue.JArray(array)
    default:
        return
    }}

public mutating func insert(dict:[Swift.String: AnyObject], atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(JSONValue(dictionary: dict), atIndex: ind)
            self = JSONValue.JArray(array)
        default:
            return
        }}

public mutating func insert(arr:[AnyObject], atIndex ind:Int) {
    switch self {
    case .JArray(var array):
        array.insert(JSONValue(array: arr), atIndex: ind)
        self = JSONValue.JArray(array)
    default:
        return
    }
}
}

// MARK: Extend methods
extension JSONValue {
    // Append method
    public mutating func extend(arr:[AnyObject]) {
        switch self {
        case .JArray(var array):
            let ext:[JSONValue] = arr.map{JSONValue(value:$0)}
            array.extend(ext)
                self = JSONValue.JArray(array)
        default:
            return
            }
        }
    public mutating func extend(arr:[JSONValue]) {
        switch self {
        case .JArray(var array):
            array.extend(arr)
            self = JSONValue.JArray(array)
        default:
            return
        }
    }
}
// MARK: Remove last method
extension JSONValue {
    public mutating func removeLast() {
        switch self {
    case .JArray(var array):
        array.removeLast()
    self = JSONValue.JArray(array)
    default:
        return
        }
    }
}





