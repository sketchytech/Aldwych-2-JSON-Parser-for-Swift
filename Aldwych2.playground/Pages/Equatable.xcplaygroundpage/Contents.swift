//: [Previous](@previous)

import Foundation

/*: 
# Equatable
Work has begun on adopting Equatable as you see here. Comparison of JSONDictionary to JSONValue and JSONArray to JSONValue to follow.
*/
JSONValue(value:"String") == JSONValue(value:"Strung")
JSONValue(value:"String") == JSONValue(value:"String")
JSONValue(dictionary:["String":1,"Strung":2]) == JSONValue(value:"String")

JSONValue(dictionary:["String":1,"Strung":2]) == JSONValue(dictionary:["String":1,"Strung":2])
JSONValue(dictionary:["String":1,"Strung":2]) == JSONValue(dictionary:["String":1,"Strung":3])
JSONValue(dictionary:["String":1,"Strung":2]) == JSONValue(dictionary:["String":1,"Strung":3])

JSONValue(array: ["String","Strung"]) == JSONValue(array: ["String","String"])
JSONValue(array: ["String","Strung"]) == JSONValue(array: ["String","Strung"])
//: [Next](@next)
