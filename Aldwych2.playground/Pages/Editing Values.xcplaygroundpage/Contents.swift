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
# Editing values
Now we have access to values we are also able to edit values
*/

if var json = jsonValue
{
    json["results"]?[0]?["artistName"]?.str // "Jack Johnson"
    json["results"]?[0]?["artistName"] = "Music Man"
    json["results"]?[0]?["artistName"]?.str // "Music Man"
    json["results"]?.removeLast()
    json["resultCount"] = json["results"]?.count
//: But not only can we edit JSONValues we can also easily transform back into data or stringify all the data or a subset of it
    json.jsonData() // transform back into JSON data
    json.stringify() // stringify JSONValues
    
    // transform a subarray into data or stringify
    json["results"]?.jsonArray?.jsonData()
    json["results"]?.jsonArray?.stringify()
    
    // extract data or stringify a nested dictionary
    json["results"]?[0]?.jsonDictionary?.jsonData()
    json["results"]?[0]?.jsonDictionary?.stringify()
}

//: [Next](@next)