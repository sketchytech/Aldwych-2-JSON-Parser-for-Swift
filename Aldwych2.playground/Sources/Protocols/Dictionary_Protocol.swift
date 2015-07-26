//
//  DictionaryProtocol.swift
//  Aldwych_2_1
//
//  Created by A J LEVINGS on 25/07/2015.
//  Copyright © 2015 Gylphi. All rights reserved.
//

import Foundation

public protocol JSONDictionaryProtocol {
    var dictionary:Dictionary<String,AnyObject> { get }
    var nsDictionary:NSDictionary { get }
    /*
    subscript (key:String) -> JSONDictionary? { get set }
    subscript (key:String) -> JSONArray? { get set }
*/
    subscript (key:String) -> JSONValue? { get set }
    subscript (key:String) -> String? { get set }
    subscript (key:String) -> NSNumber? { get set }
    subscript (key:String) -> Bool? { get set }
    subscript (key:String) -> NSNull? { get set }
    
    var jsonDict:[String:JSONValue]? { get }
    var jsonDictOpt:[String:JSONValue]?? { get }
    
    func jsonData(options:NSJSONWritingOptions, error:NSErrorPointer) -> NSData?
    func stringify(options:NSJSONWritingOptions, error:NSErrorPointer) -> String?
    
    func updateValue(value:JSONValue, forKey key:String)
    func updateValue(value:AnyObject, forKey key:String)
    func updateValue(value:[String:AnyObject], forKey key:String)
    func updateValue(value:[AnyObject], forKey key:String)


}