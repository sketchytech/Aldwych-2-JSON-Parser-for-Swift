//: [Previous](@previous)

import Foundation

/*:

# Retrieving values
Handling JSON is all about remaining type safe, knowing what it is you are expecting to have returned so that values can be transported into core Swift types.
*/
var jsonValue:JSONDictionary?

do {
    jsonValue = try JSONParser.parse(fileNamed: "iTunes.json") as? JSONDictionary
}
catch let e  {
    errorString(error: e)
}
//: Once we have our json it is possible to uncover the types within it through for-in loops and directly through subscripts.


if let json = jsonValue
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
        if let a = v.jsonArray {
            print("Key: \(k). Array: \(a)")
        }
        if let d = v.jsonDictionary {
            print(d)
        }
    }
    
    // Returns a value of known type
    if let artistName = json["results"]?[0]?["artistName"]?.str {
        artistName
    }
    
    if let artistName:String = json["results"]?[0]?["artistName"] {
        artistName
    }
}
/*:
For arrays we can follow a similarly familiar pattern when using the JSONArray type.

if let json = jsonValue where json.jsonArr != nil {
for v in json {
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
*/

//: [Next](@next)
