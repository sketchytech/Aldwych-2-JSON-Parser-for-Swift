import Foundation

// MARK: JSONValue
extension JSONValue:Equatable {}
public func ==(lhs: JSONValue, rhs: JSONValue) -> Bool {
    if let ls = lhs.str,
        rs = rhs.str {
            return ls == rs
    }
    else if let lb = lhs.bool,
        rb = rhs.bool {
            return lb == rb
    }
    else if let lno = lhs.num,
        rno = rhs.num {
            return lno == rno
    }
    else if let ln = lhs.null,
        rn = rhs.null {
            return ln == rn
    }
    else if let lA = lhs.jsonArray,
        rA = rhs.jsonArray {
            return lA == rA
    }
    else if let lA = lhs.jsonDictionary,
        rA = rhs.jsonDictionary {
            return lA == rA
    }
    else {
        return false
    }
}

// MARK: JSONDictionary == JSONValue
public func ==(lhs: JSONDictionary, rhs: JSONValue) -> Bool {
    if let rA = rhs.jsonDictionary {
            return lhs == rA
    }
    else {
        return false
    }
}
// MARK: JSONValue == JSONDictionary
public func ==(lhs: JSONValue, rhs: JSONDictionary) -> Bool {
    if let lA = lhs.jsonDictionary {
        return rhs == lA
    }
    else {
        return false
    }
}
// MARK: JSONValue == JSONArray
public func ==(lhs: JSONValue, rhs: JSONArray) -> Bool {
    if let lA = lhs.jsonArray {
        return rhs == lA
    }
    else {
        return false
    }
}

// MARK: JSONArray == JSONValue
public func ==(lhs: JSONArray, rhs: JSONValue) -> Bool {
    if let rA = rhs.jsonArray {
        return lhs == rA
    }
    else {
        return false
    }
}

