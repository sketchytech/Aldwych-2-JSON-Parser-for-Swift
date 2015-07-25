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
    
    subscript (key:Int) -> JSONValue? { get set }
    subscript (key:Int) -> String? { get set }
    subscript (key:Int) -> NSNumber? { get set }
    subscript (key:Int) -> Bool? { get set }
    subscript (key:Int) -> NSNull? { get set }
    
    mutating func append(str:String)
    mutating func append(num:NSNumber)
    mutating func append(bool:Bool)
    mutating func append(null:NSNull)
    mutating func append(dict:[String:AnyObject])
    mutating func append(arr:[AnyObject])
    mutating func append(arr:JSONValue)
    
    mutating func insert(str:String, atIndex ind:Int)
    mutating func insert(num:NSNumber, atIndex ind:Int)
    mutating func insert(bool:Bool, atIndex ind:Int)
    mutating func insert(null:NSNull, atIndex ind:Int)
    mutating func insert(dict:[String: AnyObject], atIndex ind:Int)
    mutating func insert(arr:[AnyObject], atIndex ind:Int)
    
    mutating func extend(arr:[AnyObject])
    mutating func extend(arr:[JSONValue])
    
    mutating func removeLast()
    
    var jsonArr:[JSONValue]? { get }
    var jsonArrOpt:[JSONValue]?? { get }
    
    func jsonData(options:NSJSONWritingOptions, error:NSErrorPointer) -> NSData?
    func stringify(options:NSJSONWritingOptions, error:NSErrorPointer) -> String?

    
}