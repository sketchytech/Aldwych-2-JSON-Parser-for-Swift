//
//  parser.swift
//  JSONParser
//
//  Created by Anthony Levings on 11/03/2015.
//

import Foundation

public enum JSONError:ErrorType {
    case JSONValueError(String), DataError(String), FileError(String), URLError(String)
}
// receive data
public struct JSONParser {
   
    public static func parse(urlPath urlPath:String) throws -> JSONValue {
    
        guard let url = NSURL(string:urlPath) else {
            throw JSONError.FileError("URL with path \(urlPath) is not responding to request.")
        }
        return try parse(url)
}
    
    public static func parse(fileNamed fileName:String) throws -> JSONValue {
        let pE = fileName.pathExtension
        let name = fileName.stringByDeletingPathExtension
        guard let url = NSBundle.mainBundle().URLForResource(name, withExtension: pE) else {
        throw JSONError.FileError("File not found with name \(fileName) in main bundle.")
        }
        return try parse(url)
    }
    
    public static func parse(url:NSURL) throws -> JSONValue {
        guard let d = NSData(contentsOfURL: url) else {
        throw JSONError.DataError("Failed to retrieve data from NSURL.")
        }
        return try parse(d)
    }
    
    public static func parse(json:NSData) throws -> JSONValue {

        guard let jsonObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(json, options:[]) else {
        throw JSONError.JSONValueError("NSJSONSerialization returned nil.")
        }

        if let js = jsonObject as? [String:AnyObject] {
                let a = JSONValue(dictionary: js)
                return a
        }
        else if let js = jsonObject as? [AnyObject] {
                return JSONValue(array:js)
        }
        throw JSONError.JSONValueError("Not a valid dictionary or array for parsing into JSONValue.")
        
    }
}