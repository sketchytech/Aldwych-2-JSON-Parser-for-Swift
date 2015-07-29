import Foundation

public func typesafeReplace (jValue:JSONValue, value:AnyObject) -> JSONValue {
    if jValue.str != nil && value as? String != nil {
        return JSONValue(value:value)
    }
    else if jValue.bool != nil && value as? NSNumber != nil  {
        if ((value as? NSNumber)?.isBoolNumber() == true) {
            return JSONValue(value:value)
        }
        else {
            fatalError("Attempt to replace bool with number in typesafe mode")
        }
    }
    else if jValue.num != nil && value as? NSNumber != nil {
        if ((value as? NSNumber)?.isBoolNumber() == false) {
            return JSONValue(value:value)
        }
        else {
            fatalError("Attempt to replace number with bool in typesafe mode")
        }
    }
    else if jValue.jsonArray != nil && value as? [AnyObject] != nil {
        return JSONValue(value:value)
    }
    else if jValue.jsonDictionary != nil && value as? [String:AnyObject] != nil {
        return JSONValue(value:value)
    }
    else {
        fatalError("Type safety has been breached or type is not JSON compatible")
    }
    
}