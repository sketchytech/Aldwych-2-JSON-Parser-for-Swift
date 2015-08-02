
import UIKit

/*:
## Parsing
The first step in parsing data into the JSONValue type is to use the static methods of JSONParser. For example we might have a file in the main bundle that we wish to parse:
*/
do {
    let json = try JSONParser.parse(fileNamed: "iTunes.json") as? JSONDictionary
}
catch let e  {
    errorString(error: e)
}
//: Alternatively there might be a URL from which we can retrieve JSON:
do {
    let json = try JSONParser.parse(urlPath:"https://itunes.apple.com/search?term=jack+johnson") as? JSONDictionary
}
catch let e  {
    errorString(error: e)
}



/*:
There are also methods for handling NSData and NSURL available.

**Note**: For convenience the error handling is passed off to the errorString function that can be found in the ErrorHandling.swift file.*/

//: [Next](@next)
