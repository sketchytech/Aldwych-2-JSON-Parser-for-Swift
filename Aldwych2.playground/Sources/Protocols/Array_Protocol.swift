//
//  Array_Protocol.swift
//  Aldwych_2_1
//
//  Created by A J LEVINGS on 25/07/2015.
//  Copyright © 2015 Gylphi. All rights reserved.
//

import Foundation

protocol JSONArrayProtocol {
    var array:[AnyObject] { get }
    var nsArray:NSArray { get }
    var count:Int { get }
  /*
    subscript (key:Int) -> JSONDictionary? { get set }
    subscript (key:Int) -> JSONArray? { get set }
*/
    subscript (key:Int) -> JSONValue? { get set }
    subscript (key:Int) -> AnyObject? { get set }
    
    mutating func append(value:AnyObject)
    mutating func append(arr:JSONValue)
    
    mutating func insert(str:AnyObject, atIndex ind:Int)
    
    mutating func extend(arr:[AnyObject])
    mutating func extend(arr:[JSONValue])
    
    mutating func removeLast()
    mutating func removeAtIndex(index:Int)
    
    func jsonData(options:NSJSONWritingOptions, error:NSErrorPointer) -> NSData?
    func stringify(options:NSJSONWritingOptions, error:NSErrorPointer) -> String?

}