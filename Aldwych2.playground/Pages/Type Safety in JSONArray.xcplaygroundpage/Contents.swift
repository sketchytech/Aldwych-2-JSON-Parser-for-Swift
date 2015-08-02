//: [Previous](@previous)

import Foundation

/*:
# Type safety in JSONArray
Dictionaries might have set value types for keys, but JSON arrays are likely to be less strict. Therefore, as a rule when subscripting values into arrays type safety is ignored.
*/

var arr = JSONArray(array:["One","Two", 3, 4])
arr[0] = 1
//: We can avoid going beyond the bounds of an array by using startIndex and endIndex in the familiar way.
if advance(arr.startIndex,2,arr.endIndex) != arr.endIndex {
    arr[advance(arr.startIndex,2),.Typesafe] = 3
}
//: And type safety can be applied in the following way:
arr[2,.Typesafe] = 2
arr[2].num
//: Using .Unsafe where you want to be specific about the lack of type safety.
arr[2,.Unsafe] = "Two"
arr[2].str
//: To assist in mainting type safety, there are a range of methods for testing whether the current type can be replaced with another:
if arr[1].canReplaceWithString() == true {
    arr[1,.Typesafe] = "Three"
}
//: And so to be both type safe and avoid going beyond the bounds of an array, we can write code like this:
if advance(arr.startIndex,1,arr.endIndex) != arr.endIndex && arr[advance(arr.startIndex,1)].canReplaceWithString() == true {
    arr[advance(arr.startIndex,1),.Typesafe] = "Four"
}

//: If you wish to explicitly identify a lack of type safety then use unsafe:
arr[1,.Unsafe] = 2
//: **Warning**: If you choose to make a type-safe replacement and attempt to insert a value of a different type into the array a crash will occur. 

//: [Next](@next)
