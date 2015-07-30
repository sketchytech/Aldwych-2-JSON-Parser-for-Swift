import Foundation

// MARK: Extract Array
extension JSONValue: JSONArrayProtocol {
    public var array:[AnyObject] {
        var array = [AnyObject](count: self.count, repeatedValue: 0)
        switch self {
        case .JArray(let arr):
            for v in arr.enumerate() {
                if let a: AnyObject = v.1.str ?? v.1.num ?? v.1.bool ?? v.1.null {
                    array[v.0] = a
                }
                else if v.1.jsonDictionary != nil {
                    array[v.0] = v.1.dictionary as AnyObject
                }
                else if v.1.jsonArray != nil {
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
                else if v.jsonDictionary != nil {
                    array.addObject(v.nsDictionary)
                }
                else if v.jsonArray != nil {
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
      public subscript (key:Int) -> JSONValue {
        get {
            switch self {
            case .JArray (let a):
                if key >= a.endIndex {
                    fatalError("Beyond bounds of Array.")
                }
                return a[key]
                
            default:
                fatalError("Not an Array.")
            }}
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    fatalError("Tried to insert a value beyond the final value in the array")
                }
                else  {
                    a[key] = newValue
                    self = .JArray(a)
                }
            default:
                fatalError("Not an Array.")
            }}
    }
    
    
    public subscript (key:Int) -> AnyObject {
        get {
            fatalError("You shouldn't be trying to retrieve AnyObject from a JSONArray!")
            }
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    fatalError("Tried to insert a value beyond the final value in the array")
                }
                else  {
                    a[key] = JSONValue(value:newValue)
                    self = .JArray(a)
                }
            default:
                fatalError("Not an Array.")
            }}
    }
    
    public subscript (key:Int, typesafe:TypeSafety) -> AnyObject {
        get {
            fatalError("You shouldn't be trying to retrieve AnyObject from a JSONArray!")
        }
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    fatalError("Tried to insert a value beyond the final value in the array")
                }
                else if case .Unsafe = typesafe {
                    a[key] = JSONValue(value:newValue)
                    self = .JArray(a)
                }
                else if case .Typesafe = typesafe {
                    a[key] = typesafeReplace(a[key], value:newValue)
                    self = .JArray(a)
                }
                
            default:
                fatalError("Not an Array.")
            }}
    }
    

    
    
}


// MARK: Append methods
extension JSONValue {
    // Append method
    public mutating func append(value:AnyObject) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(value:value))
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
public mutating func insert(value:AnyObject, atIndex ind:Int) {
    switch self {
    case .JArray(var array):
        array.insert(JSONValue(value:value), atIndex: ind)
        self = JSONValue.JArray(array)
    default:
        return
    }
}
    
    public mutating func insert(value:JSONValue, atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(value, atIndex: ind)
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
    public mutating func removeAtIndex(index:Int) {
        switch self {
        case .JArray(var array):
            array.removeAtIndex(index)
            self = JSONValue.JArray(array)
        default:
            return
        }
    }
  }





