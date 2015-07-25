import Foundation

// FIXME: JSONValueType not currently used (error raised)
public protocol JSONValueType {

    var str:String? { get }
    var strOpt:String?? { get }
    
    var num:NSNumber? { get }
    var numOpt:NSNumber?? { get }
    
    var bool:Bool? { get }
    var boolOpt:Bool?? { get }
    var null:NSNull? { get }
    
    var jsonArr:[JSONValue]? { get }
    var jsonArrOpt:[JSONValue]?? { get }
    var jsonDict:[String:JSONValue]? { get }
    var jsonDictOpt:[String:JSONValue]?? { get }
    
    // subscripting Arrays
    
    subscript (key:Int) -> JSONValue? {get set}
        
    subscript (key:Int) -> String? {get set}
        
    subscript (key:Int) -> NSNumber? {get set}
    
    subscript (key:Int) -> Bool? {get set}
        
    subscript (key:Int) -> NSNull? { get set }
    
    subscript (key:String) -> JSONValue? {get set}
    
    subscript (key:String) -> String? {get set}
    
    subscript (key:String) -> NSNumber? {get set}
    
    subscript (key:String) -> Bool? {get set}
    
    subscript (key:String) -> NSNull? { get set }
    

}
public protocol JSONParserType {

    static func parse(urlPath urlPath:String) throws -> JSONObjectType
    static func parse(fileNamed fileName:String) throws -> JSONObjectType
    static func parse(url:NSURL) throws -> JSONObjectType
    static func parse(json:NSData) throws -> JSONObjectType
    
}
public protocol JSONObjectType {
    
}