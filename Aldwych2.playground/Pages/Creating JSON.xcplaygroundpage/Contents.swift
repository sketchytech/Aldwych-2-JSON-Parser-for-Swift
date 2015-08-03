//: [Previous](@previous)

import Foundation

/*:
# Creating JSON
It's simple to create JSONArray, JSONDictionary and JSONValue instances, and in turn to create NSData from those instances for saving to disk or sending over a network.
*/
let json = JSONArray(array: [0,"One","Two",3,4,5.0,true,false])
let data = json.jsonData()

// Demonstration that JSON data matches original values.
if let d = data {
    NSString(data: d, encoding: NSUTF8StringEncoding)
}


//: [Next](@next)
