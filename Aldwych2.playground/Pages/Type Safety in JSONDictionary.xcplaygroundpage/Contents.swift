//: [Previous](@previous)

import Foundation

/*:
# Type Safety in JSONDictionary
One of the most important features of Swift is type safety and if we don't carry this over to JSON then JSONArray, JSONDictionary and JSONValue become simply a variation of AnyObject with some added methods. In order to carry type safety over to JSON (and to maintain consistency between JSONArray and JSONDictionary, a regular subscripting of a JSON dictionary is unsafe but can be made safe by using .Typesafe after the subscripting key.
*/
var d = JSONDictionary(dictionary:["One":true,"Two":1])

d["Two"] = "fourteen" // unsafe type changes OK

d["Two",.Unsafe] = 14 // unsafe type changes OK and explicitly marked as so
d["Two",.Typesafe] = 16 // type safe and if type didn't match the current type a crash would occur

/*:
The implementation of type safety in the first version of Aldwych was done on a whole object basis which could become confusing, so here type safety happens on an update by update basis and this makes it clearer in the code what is happening. And if you wish to use updateValue instead of subscripting this is implemented in a similar way. Although here typesafety must always be specified one way or another.
*/

d.updateValue(2, forKey: "Two", typesafe: .Typesafe) // ["One": false, "Two": 2]

//: The consequences of passing a value of a different type when typesafe is declared as true is a fatalError crash.
// a.updateValue(false, forKey: "Two", typesafe: .Typesafe) // this code generates a fatal error, uncomment and expand debug area below to see
//: Where type safety is not a consideration always set typesafe to .Unsafe.
d.updateValue("Hello", forKey: "Two", typesafe: .Unsafe) // ["One": false, "Two": "Hello"]
//: Currently if a value is null it is assumed that it can be changed to any new value. To convert an existing value to null can be done through turning type safety off but can also be performed in an easier way using a unique method: nullValueForKey()
d.nullValueForKey("One")
d["One"]?.null == NSNull() // true
//: If you are uncertain of the type of value you wish to change, always test first
if d["One"]?.bool != nil || d["One"]?.null != nil {
    d.updateValue(true, forKey: "One", typesafe: .Typesafe) // ["One": true, "Two": "Hello"]
}
//: and to save repetition there are some convenience methods you can use here:

if d["One"]?.canReplaceWithBool() == true {
    d.updateValue(false, forKey: "One", typesafe: .Typesafe) // ["One": false, "Two": "Hello"]
}

d["One"]?.canReplaceWithString() // false, so we'd never try and make a type safe substitution of the value with a String

//: Note: Aldwych 2.0 is being updated regularly, so please ensure you keep up to date with the latest version of the playground.

//: [Next](@next)
