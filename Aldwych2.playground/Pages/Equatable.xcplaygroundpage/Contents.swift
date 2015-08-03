//: [Previous](@previous)

import Foundation

/*: 
# Equatable
A broad range of comparisons 
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
//: Since JSONArray and JSDictionary adopt SequenceType and their elements (JSONValue) adopt Equatable, it is also possible to use contains()
JSONArray(array: ["String","Strung"]).contains("String")
JSONArray(array: ["String","Strung",2,3,4]).contains(4)
//: JSONArray and JSONDictionary also adopt Equatable themselves, and so [JSONDictionary], [JSONArray] and [JSONValue] arrays can all be compared
[JSONArray(array: ["String","Strung"]),JSONArray(array: ["String","Strung"]), JSONArray(array: ["String","Strung",2,3,4])] == [JSONArray(array: ["String","Strung"]),JSONArray(array: ["String","Strung"]), JSONArray(array: ["String","Strung",2,3,4])]
//: And contains used with them as well:
[JSONArray(array: ["String","Strung"]),JSONArray(array: ["String","Strung"]), JSONArray(array: ["String","Strung",2,3,4])].contains(JSONArray(array: ["String","Strung"]))
//: [Next](@next)
