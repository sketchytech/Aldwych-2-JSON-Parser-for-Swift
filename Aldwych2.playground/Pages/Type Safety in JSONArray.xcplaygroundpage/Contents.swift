//: [Previous](@previous)

import Foundation

/*:
# Type safety in JSONArray
Dictionaries might have set value types for keys, but JSON arrays are likely to be less strict. Therefore, as a rule when subscripting values into arrays type safety is ignored.
*/

var a = JSONArray(array:["One","Two", 3, 4])
a[0] = 1
//: You can, however, force typesafety in the following way:
a[2,true] = 2
a[2]?.num
//: To assist in mainting type safety, there are a range of methods for testing whether the current type can be replaced with another:
if a[1]?.canReplaceWithString() == true {
    a[1,true] = "Three"
}
//: **Warning**: If you choose to make a type-safe replacement and attempt to insert a value of a different type into the array a crash will occur. 

//: [Next](@next)
