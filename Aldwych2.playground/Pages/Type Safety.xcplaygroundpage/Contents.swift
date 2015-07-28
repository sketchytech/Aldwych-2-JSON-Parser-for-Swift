//: [Previous](@previous)

import Foundation

/*:
# Type Safety in JSONDictionary
One of the most important features of Swift is type safety and if we don't carry this over to JSON then JSONArray, JSONDictionary and JSONValue become simply a variation of AnyObject with some added methods.

The implementation of type safety in the first version of Aldwych was done on a whole object basis which could become confusing, so here type safety happens on an update by update basis and typesafe is the default unless you set it to false.
*/
var a = JSONDictionary(dictionary:["One":true,"Two":1])

a.updateValue(12, forKey: "Two", typesafe: true) // ["One": false, "Two": 12]
a.updateValue(14, forKey: "Two") // true is always the default for typesafe

//: The consequences of passing a value of a different type when typesafe is declared as true is a fatalError crash.
// a.updateValue(false, forKey: "Two") // this code generates a fatal error, uncomment and expand debug area below to see
//: Where type safety is not a consideration always set typesafe to false.
a.updateValue("Hello", forKey: "Two", typesafe: false) // ["One": false, "Two": "Hello"]
//: Currently if a value is null it is assumed that it can be changed to any new value. To convert an existing value to null can be done through turning type safety off but can also be performed in an easier way using a unique method: nullValueForKey()
a.nullValueForKey("One")
a["One"]?.null == NSNull() // true
//: If you are uncertain of the type of value you wish to change, always test first
if a["One"]?.bool != nil || a["One"]?.null != nil {
    a.updateValue(true, forKey: "One") // ["One": true, "Two": "Hello"]
}
//: and to save repetition there are some convience methods you can use here:

if a["One"]?.canReplaceWithBool() == true {
    a.updateValue(false, forKey: "One") // ["One": false, "Two": "Hello"]
}

a["One"]?.canReplaceWithString() // false, so we'd never try and make a type safe substitution of the value with a String

//: Type safety for JSONArray is to follow. Aldwych 2.0 is being updated regularly, so please ensure you keep up to date with the latest version of the playground.

//: [Next](@next)
