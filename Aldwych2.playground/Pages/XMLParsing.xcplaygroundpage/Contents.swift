//: [Previous](@previous)

import Foundation


/*:
# XML Parsing
Finally here's a brief look at parsing XML in and out of JSON
*/

if let url = NSBundle.mainBundle().URLForResource("styles", withExtension: "xml"),
    a = NSData(contentsOfURL: url) {
        let b = XMLParser()
        let c = b.parse(a)
        let d = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" + XMLParser.json2xml(c)!
        
}

