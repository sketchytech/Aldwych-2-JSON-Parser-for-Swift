import Foundation


public enum JSONArray:JSONObjectType {
    case JArray([JSONValue])
}


// subscripting Arrays
extension JSONArray: JSONArrayProtocol {
  
    public subscript (key:Int) -> JSONValue? {
        get {
            switch self {
            case .JArray (let a):
                if key >= a.endIndex {
                    return nil
                }
                return a[key]
                
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
            }}
    }
    
    
    public subscript (key:Int) -> String? {
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
          
            }}
    }
}

// Array Generator
public struct JSONArrayGenerator:GeneratorType {
    // use dictionary with index as keys for position in array
    let value:JSONArray
    var indexInSequence:Int = 0
    
    init(value:JSONArray) {
        self.value = value
        
    }
    
    mutating public func next() -> JSONValue? {
        switch value {
        case .JArray (let Array) where !Array.isEmpty:
            
            if indexInSequence < Array.count
            { let element = Array[indexInSequence]
                ++indexInSequence
                return element
            }
            else { indexInSequence = 0
                return nil
            }
            
        default:
            return nil
        }
    }
}

extension JSONArray {
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
        }
        return array
    }
}

extension JSONArray {
    public init (array:[AnyObject]) {
        self = JSONArray.JArray(array.map{JSONValue(value:$0)})
    }
    // FIXME: add init for [JSONValue]
}


extension JSONArray: SequenceType  {
    
    public typealias Generator  = JSONArrayGenerator
    public func generate() -> Generator {
        let gen = Generator(value: self)
        return gen
    }
}


extension JSONArray {
    public var count:Int {
        switch self {
        case .JArray(let arr):
            return arr.count
        }
        
    }
    public var last:JSONValue? {
        switch self {
        case .JArray(let arr):
            return arr.last
        }
        
    }
}

// MARK: Append methods
extension JSONArray {
    // Append method
    public mutating func append(str:String) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(str))
            self = JSONArray.JArray(array)
        }
    }
    
    public mutating func append(num:NSNumber) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(num))
            self = JSONArray.JArray(array)
        }
    }
    public mutating func append(bool:Bool) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(bool))
            self = JSONArray.JArray(array)
        }
        
    }
    
    public mutating func append(null:NSNull) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(null))
            self = JSONArray.JArray(array)
        }
    }
    
    public mutating func append(dict:[String:AnyObject]) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(dictionary: dict))
            self = JSONArray.JArray(array)
        }
    }
    
    public mutating func append(arr:[AnyObject]) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(array:arr))
            self = JSONArray.JArray(array)
        }
    }
    
    public mutating func append(arr:JSONValue) {
        switch self {
        case .JArray(var array):
            array.append(arr)
            self = JSONArray.JArray(array)
        }
    }
    
}

// MARK: Insert methods
extension JSONArray {
    public mutating func insert(str:String, atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(JSONValue(str), atIndex: ind)
            self = JSONArray.JArray(array)
   
        }
    }
    public mutating func insert(num:NSNumber, atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(JSONValue(num), atIndex: ind)
            self = JSONArray.JArray(array)
   
        }
    }
    
    public mutating func insert(bool:Bool, atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(JSONValue(bool), atIndex: ind)
            self = JSONArray.JArray(array)
     
        }
    }
    
    public mutating func insert(null:NSNull, atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(JSONValue(null), atIndex: ind)
            self = JSONArray.JArray(array)
       
        }}
    
    public mutating func insert(dict:[String: AnyObject], atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(JSONValue(dictionary: dict), atIndex: ind)
            self = JSONArray.JArray(array)
       
        }}
    
    public mutating func insert(arr:[AnyObject], atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(JSONValue(array: arr), atIndex: ind)
            self = JSONArray.JArray(array)
    
        }
    }
}


// MARK: Extend methods
extension JSONArray {
    // Append method
    public mutating func extend(arr:[AnyObject]) {
        switch self {
        case .JArray(var array):
            let ext:[JSONValue] = arr.map{JSONValue(value:$0)}
            array.extend(ext)
            self = JSONArray.JArray(array)
   
        }
    }
    public mutating func extend(arr:[JSONValue]) {
        switch self {
        case .JArray(var array):
            array.extend(arr)
            self = JSONArray.JArray(array)

        }
    }
}

// MARK: Remove last method
extension JSONArray {
    public mutating func removeLast() {
        switch self {
        case .JArray(var array):
            array.removeLast()
            self = JSONArray.JArray(array)
        }
    }
    public mutating func removeAtIndex(index:Int) {
        switch self {
        case .JArray(var array):
            array.removeAtIndex(index)
            self = JSONArray.JArray(array)
        }
    }

    
}



