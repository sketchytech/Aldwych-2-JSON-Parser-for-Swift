//: [Previous](@previous)

import Foundation

/*:
# Type Safety in JSONDictionary
One of the most important features of Swift is type safety and if we don't carry this over to JSON then JSONArray, JSONDictionary and JSONValue become simply a variation of AnyObject with some added methods.

The implementation of type safety in the first version of Aldwych was done on a whole object basis which could become confusing, so here type safety happens on an update by update basis and typesafe is the default unless you set it to false.
*/
var a = JSONDictionary(dictionary:["One":true,"Two":1])

do {
    try a.updateValue(false, forKey: "Two", typesafe: true) // this code generates a an error
}
catch let e {
    errorString(error: e)
}
//: Where type safety is not a consideration there won't be errors to catch, so we can always use try!
try! a.updateValue("Hello", forKey: "Two", typesafe: false) 
a // ["One": false, "Two": "Hello"]
//: Currently if a value is null it is assumed that it can be changed to any new value. To convert an existing value to null can be done through turning type safety off but can also be performed in an easier way using a unique method: nullValueForKey()
a.nullValueForKey("One")
a["One"]?.null == NSNull() // true
//: If you want to retain type safety but don't like the do-try-catch approach then you can check for nil beforehand:
if a["One"]?.bool != nil || a["One"]?.null != nil {
    try! a.updateValue(true, forKey: "One") // default for typesafe is true
    a // ["One": true, "Two": 1]
}
//: and to save repetition there are some convience methods you can use here:

if a["One"]?.canReplaceWithBool() == true {
    try! a.updateValue(false, forKey: "One")
    a // ["One": false, "Two": 1]
}

a["One"]?.canReplaceWithString() // false, so we'd never try and make a type safe substitution of the value with a String

//: Type safety for JSONArray is to follow. Aldwych 2.0 is being updated regularly, so please ensure you keep up to date with the latest version of the playground.

//: [Next](@next)
