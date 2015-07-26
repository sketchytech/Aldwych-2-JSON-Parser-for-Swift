//: [Previous](@previous)

import Foundation


var jsonValue:JSONDictionary?

do {
    jsonValue = try JSONParser.parse(fileNamed: "iTunes.json") as? JSONDictionary
}
catch let e  {
    errorString(error: e)
}
/*:
# Adding and replacing
## Dictionaries and Arrays
For adding and replacing dictionaries and arrays currently use the methods updateValue(forKey:) and insert(atIndex:) respectively
*/

if var json = jsonValue
{
    // adding a dictionary to a dictionary
    json.updateValue(["results":10], forKey:"moreResults")
    // removing an object from an array
    json["results"]?.removeAtIndex(0)
    // adding an array to an array
    json["results"]?.insert(["FoundStuff","Found More Stuff"], atIndex:0)
    
    json.jsonData() // transform back into JSON data
    json.stringify() // stringify JSONValues
    
    
}

//: [Next](@next)
