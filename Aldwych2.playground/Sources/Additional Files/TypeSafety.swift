import Foundation

/// **.Typesafe**: Type must be exchanged for type (exceptions: where current value is null or key/value not currently in JSONDictionary) **.Unsafe**: any JSON compatible type can be exchanged for any other JSON compatible type.
public enum TypeSafety {
    case Typesafe, Unsafe
}
/// Takes existing JSONValue and returns a new JSONValue initialized from the value parameter if they are of the same type. If they are not the same type a fatalError crash occurs and a message is sent.
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