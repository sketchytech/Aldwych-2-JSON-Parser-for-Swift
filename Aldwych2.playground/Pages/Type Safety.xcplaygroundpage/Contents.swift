//: [Previous](@previous)

import Foundation

/*:
# Type Safety in JSONDictionary
One of the most important features of Swift is type safety and if we don't carry this over to JSON then JSONArray, JSONDictionary and JSONValue become simply a variation of AnyObject with some added methods.

The implementation of type safety in the first version of Aldwych was done on a whole object basis which could become confusing, so here type safety happens on an update by update basis and typesafe is the default unless you set it to false.
*/
var a = JSONDictionary(dictionary:["One":true,"Two":1])

a.updateValue(false, forKey: "One", typesafe: true) // ["One": false, "Two": 1]
a.updateValue(false, forKey: "Two") // ["One": false, "Two": 1]
a.updateValue(false, forKey: "Two", typesafe: false) // ["One": false, "Two": false]

//: Currently if a value is null it is assumed that it can be changed to any new value. To convert an existing value to null can be done through turning type safety off but can also be performed in an easier way using a unique method: nullValueForKey()

a.nullValueForKey("One")
a["One"]?.null == NSNull() // true

//: Type safety for JSONArray is to follow. Aldwych 2.0 is being updated regularly, so please ensure you keep up to date with the latest version of the playground.

//: [Next](@next)
