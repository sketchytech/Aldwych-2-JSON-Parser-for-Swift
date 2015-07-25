//
//  XMLParser.swift
//  SaveFile
//
//  Created by Anthony Levings on 31/03/2015.
//

import Foundation

public class XMLParser:NSObject, NSXMLParserDelegate {
    
    // where the dictionaries for each tag are stored
    var elementArray = JSONValue.JArray([JSONValue]())
    var contentArray = JSONValue.JArray([JSONValue]())
    // final document array where last dictionary
    var document = JSONValue.JDictionary([String:JSONValue]())
    
    
 public func parse(xml:NSData) -> JSONValue {
        let xml2json = NSXMLParser(data: xml)
        // xml2json.shouldProcessNamespaces = true
        xml2json.delegate = self
        xml2json.parse()
        return document
    }
    
public func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        
        // current dictionary is the newly opened tag
        elementArray.append(JSONValue(dictionary: [elementName:"", "attributes":attributeDict]))
        
        
        // every new tag has an array added to the holdingArr
        contentArray.append(JSONValue.JArray([JSONValue]()))
        
    }
    
public func parser(parser: NSXMLParser, foundCharacters string: String) {
            // current array is always the last item in holding, add string to array
            contentArray[contentArray.count-1]?.append(string)
            }
    
public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // current array, which might be one string or a nested set of elements is added to the current dictionary
        if contentArray.count > 0 {
            for (k,_) in elementArray.last! {
                if k != "attributes" {
                    elementArray[elementArray.count-1]?[k] = contentArray.last
                }
            }
            
        }
        
        // add the current dictionary to the array before if there is one
        if contentArray.count > 1 {
            
            // FIXME: pointless extraction of dictionary to re-encode
            // add the dictionary into the previous JSONArray of the holdingArray
            contentArray[contentArray.count-2]?.append(JSONValue((elementArray[elementArray.count-1]?.jsonDict)!))
            
            
            // remove the dictionary
            if elementArray.count > 0 {
                // remove the array of the current dictionary that has already been assigned
                elementArray.removeLast()
            }
            if contentArray.count > 0 {
                contentArray.removeLast()
            }
            
        }
        
        
        
        
    }
    
public func parserDidEndDocument(parser: NSXMLParser) {
        if let doc = elementArray.last { document = doc }
        
    }
    
    
    
    private static func xmlEntities(str:String) -> String {
        let xmlEntities = ["\"":"&quot;","&":"&amp;","'":"&apos;","<":"lt",">":"&gt;"]
        var strA = str
        for (k,v) in xmlEntities {
            strA = strA.stringByReplacingOccurrencesOfString(k, withString: v, options: [], range: Range(start: strA.startIndex, end: strA.endIndex))
        }
        return strA
        
    }
    // used to take a JSONDictionary
   public  static func json2xml(json:JSONValue)->String? {
        
        let str = json2xmlUnchecked(json)
        
        if let d = str.dataUsingEncoding(NSUTF8StringEncoding) {
            
            let xml = NSXMLParser(data: d)
            if xml.parse() == true {
                
                
                return str
            }
            else {return nil }
        }
        else {return nil }
    }
    // used to take a JSONDictionary
    private static func json2xmlUnchecked(json:JSONValue) -> String {
        
        // TODO: bit of a fudge to allow the method to take a JSONDictionary, think about using protocol or reworking the method, OK for now - it works!
        let jArray = JSONValue(array:[json.dictionary])
        return json2xmlUnchecked2(jArray)
    }
    private static func json2xmlUnchecked2(json:JSONValue) -> String {
        
        
        var bodyHTML = ""
        for (_,b) in json {
            // if it's a string we simply add the string to the bodyHTML string
            if let str = b.str {
                
                bodyHTML += xmlEntities(str)
                // This bit works
                
            }
                
                // if it's a dictionary we know it has a tag key
            else if let _ = b.jsonDict
            {

                bodyHTML += extractFromDictionaryXml2json(b)
                
            }
                
                // it shouldn't be an array, and this can most likely be removed
            else if let _ = b.jsonArr
            {
                bodyHTML += json2xmlUnchecked2(b)
                
            }
        }
        
        return bodyHTML
    }
    static func extractFromDictionaryXml2json(dict:JSONValue) -> String {
        var elementHTML = ""
        for (k,v) in dict {
            // if it matches one in the list of tags in the body template work through that element's array to build the relevant HTML
            if k != "attributes" {
                elementHTML += "<"
                elementHTML += k
                if let atts = dict["attributes"]?.jsonDict {
                    for (k,v) in atts {
                        elementHTML += " "
                        elementHTML += k
                        elementHTML += "=\""
                        if let s = v.str {
                            elementHTML += s
                            
                        }
                        elementHTML += "\""
                    }
                    
                    elementHTML += ">"
                }
                if let text = v.str {
                    elementHTML += xmlEntities(text)
                    
                }
                if let _ = v.jsonArr {
                    elementHTML += json2xmlUnchecked2(v)
                    
                }
                
                elementHTML += "</"
                elementHTML += k
                elementHTML += ">"
            }
                
            else if let _ = dict[k]?.jsonArr {
                // cycle back through
                elementHTML += json2xmlUnchecked2(dict[k]!)
            }
            
        }
        return elementHTML
    }
    
}