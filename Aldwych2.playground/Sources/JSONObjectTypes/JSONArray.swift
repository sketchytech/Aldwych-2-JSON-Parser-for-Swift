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
                    fatalError("Tried to insert a value beyond the final value in the array.")
                }
                else if let nV = newValue {
                    a[key] = nV
                    self = .JArray(a)
                }
            }}
    }
    
    
    public subscript (key:Int) -> AnyObject? {
        get {
            return nil
        }
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    fatalError("Tried to insert a value beyond the final value in the array.")
                }
                else if let nV = newValue {
                    a[key] = JSONValue(value:nV)
                    self = .JArray(a)
                }

            }}
    }
    
    public subscript (key:Int, typesafe:Bool) -> AnyObject? {
        get {
            return nil
        }
        set(newValue) {
            switch self {
            case .JArray (var a):
                if key >= a.endIndex {
                    fatalError("Tried to insert a value beyond the final value in the array.")
                }
                guard let nV = newValue else {
                    fatalError("No value to insert into array")
                }
                
                if typesafe == false {
                    a[key] = JSONValue(value:nV)
                    self = .JArray(a)
                }
                else if typesafe == true {
                    a[key] = typesafeReplace(a[key], value:nV)
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
    public mutating func append(value:AnyObject) {
        switch self {
        case .JArray(var array):
            array.append(JSONValue(value:value))
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
    public mutating func insert(value:AnyObject, atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(JSONValue(value:value), atIndex: ind)
            self = JSONArray.JArray(array)
   
        }
    }
    
    public mutating func insert(value:JSONValue, atIndex ind:Int) {
        switch self {
        case .JArray(var array):
            array.insert(value, atIndex: ind)
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



