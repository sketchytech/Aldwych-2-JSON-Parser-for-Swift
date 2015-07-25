//: [Previous](@previous)

import Foundation

/*:

# Retrieving values
Handling JSON is all about remaining type safe, knowing what it is you are expecting to have returned so that values can be transported into core Swift types.
*/
var jsonValue:JSONValue?

do {
    jsonValue = try JSONParser.parse(fileNamed: "iTunes.json")
}
catch let e  {
    errorString(error: e)
}
//: Once we have our json it is possible to uncover the types within it through for-in loops and directly through subscripts.


if let json = jsonValue where json.jsonDict != nil
{
    for (k,v) in json {
        
        if let s = v.str {
            print(s)
        }
        if let n = v.num {
            print("Key: \(k). Value: \(n).")
        }
        if let n = v.null {
            print(n)
        }
        if let a = v.jsonArr {
            print("Key: \(k). Array: \(a)")
        }
        if let d = v.jsonDict {
            print(d)
        }
    }
    
    json["results"]?[0]?["artistName"]?.str
}
//: Note that for arrays we can follow a similarly familiar pattern, but you must currently use (_,v) rather than simply v. This is a current limitation of the JSONValue type, which I would like to fix but I've yet to find a way of doing this without a large expansion in code and greater compromises in other areas. I am hopeful, however, that a future version of Swift will enable (_,v) to become simply v.

if let json = jsonValue where json.jsonArr != nil
{
    for (_,v) in json {
        if let s = v.str {
            print(s)
        }
        if let n = v.num {
            print(n)
        }
        if let n = v.null {
            print(n)
        }
        if let a = v.jsonArr {
            print(a)
        }
        if let d = v.jsonDict {
            print(d)
        }
    }
}

//: [Next](@next)
