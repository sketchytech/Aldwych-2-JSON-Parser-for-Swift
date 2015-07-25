import Foundation

extension JSONValue {
    public func jsonData(options:NSJSONWritingOptions = [], error:NSErrorPointer = nil) -> NSData? {
        switch self {

        case .JArray(_):
            return try! NSJSONSerialization.dataWithJSONObject(self.array, options: options)
        case .JDictionary(_):
            return try! NSJSONSerialization.dataWithJSONObject(self.dictionary, options: options)
        default:
            return nil
        }
        
    }
    
    public func stringify(options:NSJSONWritingOptions = [], error:NSErrorPointer = nil) -> Swift.String? {
        switch self {
            
        case .JArray(_):
            let data = try! NSJSONSerialization.dataWithJSONObject(self.array, options: options)
            let count = data.length / sizeof(UInt8)
            
            // create array of appropriate length:
            var array = [UInt8](count: count, repeatedValue: 0)
            
            // copy bytes into array
            data.getBytes(&array, length:count * sizeof(UInt8))
            
            
            return Swift.String(bytes: array, encoding: NSUTF8StringEncoding)
            
            
        case .JDictionary(_):
            let data = try! NSJSONSerialization.dataWithJSONObject(self.dictionary, options: options)
            let count = data.length / sizeof(UInt8)
                
                // create array of appropriate length:
                var array = [UInt8](count: count, repeatedValue: 0)
                
                // copy bytes into array
                data.getBytes(&array, length:count * sizeof(UInt8))
                
                
                return Swift.String(bytes: array, encoding: NSUTF8StringEncoding)
                
            
        default:
            return nil
        }
        
    }
    
    
}

extension JSONDictionary {
    public func jsonData(options:NSJSONWritingOptions = [], error:NSErrorPointer = nil) -> NSData? {
        switch self {
        case .JDictionary(_):
            return try! NSJSONSerialization.dataWithJSONObject(self.dictionary, options: options)
    
        }
        
    }
    
    public func stringify(options:NSJSONWritingOptions = [], error:NSErrorPointer = nil) -> Swift.String? {
        switch self {
            
        case .JDictionary(_):
            let data = try! NSJSONSerialization.dataWithJSONObject(self.dictionary, options: options)
            let count = data.length / sizeof(UInt8)
            
            // create array of appropriate length:
            var array = [UInt8](count: count, repeatedValue: 0)
            
            // copy bytes into array
            data.getBytes(&array, length:count * sizeof(UInt8))
            
            
            return String(bytes: array, encoding: NSUTF8StringEncoding)
            
     
        }
        
    }
    
    
}

extension JSONArray {
    public func jsonData(options:NSJSONWritingOptions = [], error:NSErrorPointer = nil) -> NSData? {
        switch self {
            
        case .JArray(_):
            return try! NSJSONSerialization.dataWithJSONObject(self.array, options: options)
        }
        
    }
    
    public func stringify(options:NSJSONWritingOptions = [], error:NSErrorPointer = nil) -> Swift.String? {
        switch self {
            
        case .JArray(_):
            let data = try! NSJSONSerialization.dataWithJSONObject(self.array, options: options)
            let count = data.length / sizeof(UInt8)
            
            // create array of appropriate length:
            var array = [UInt8](count: count, repeatedValue: 0)
            
            // copy bytes into array
            data.getBytes(&array, length:count * sizeof(UInt8))
            
            
            return Swift.String(bytes: array, encoding: NSUTF8StringEncoding)
            
            
        }
        
    }
    
    
}