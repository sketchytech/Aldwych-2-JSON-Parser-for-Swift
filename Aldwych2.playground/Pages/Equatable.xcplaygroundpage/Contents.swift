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

JSONArray(array: ["String","Strung"]) == JSONValue(value: [["String","String"],["String","Strung"]])[1]
JSONArray(array: ["String","Strung"]) == JSONValue(value: [["String","String"],["String","Strung"]])[0]

JSONDictionary(dictionary:["String":1,"Strung":2]) == JSONValue(dictionary:["Swing":["String":1,"Strung":2]])
if JSONValue(dictionary:["Swing":["String":1,"Strung":2]])["Swing"] != nil {
   JSONValue(dictionary:["Swing":["String":1,"Strung":2]])["Swing"]! == JSONDictionary(dictionary:["String":1,"Strung":2])
}

JSONArray(array: ["String","Strung"]).contains("String")
JSONArray(array: ["String","Strung",2,3,4]).contains(4)


//: [Next](@next)
