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
            if lA.count != rA.count {
                return false
            }
            for v in lA.enumerate() {
                if v.element != rA[v.index] {
                    return false
                }
                
            }
            return true
    }
    else if let jD = lhs.jsonDictionary,
        rJD = rhs.jsonDictionary {
            for (k,_) in jD {
                if jD[k] != rJD[k] {
                    return false
                }
            }
            for (k,_) in rJD {
                if jD[k] != rJD[k] {
                    return false
                }
            }
            return true
    }
    else {
        return false
    }
}
