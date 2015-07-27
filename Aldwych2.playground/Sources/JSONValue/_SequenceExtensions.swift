import Foundation
protocol JSONGeneratorProtocol:GeneratorType {
    
}
// MARK: Sequence type
// FIXME: Necessary to repeat generator for JSONValue.JDictionary and JSONDictionary?
// Generator
public struct JSONGenerator:JSONGeneratorProtocol {
    // use dictionary with index as keys for position in array
    let value:JSONValue
    var indexInSequence:Int = 0
    
    init(value:JSONValue) {
        self.value = value
        
    }
    
    mutating public func next() -> (String,JSONValue)? {
        switch value {
        case .JArray (let Array) where !Array.isEmpty:
            
            if indexInSequence < Array.count
            { let element = Array[indexInSequence]
                ++indexInSequence
                return ("",element)
            }
            else { indexInSequence = 0
                return nil
            }
        case .JString (let jsonString) where jsonString.characters.count > 0:
            let Array = jsonString.characters.map{JSONValue(String($0))}
            if indexInSequence < Array.count
            { let element = Array[indexInSequence]
                ++indexInSequence
                return ("",element)
            }
            else { indexInSequence = 0
                return nil
            }
        case .JDictionary (let dictionary):
            let keyArray = [String](dictionary.keys)
            if indexInSequence < dictionary.count
            {   let key = keyArray[indexInSequence]
                let element = dictionary[key]
                ++indexInSequence
                return (key,element!)
            }
            else {
                indexInSequence = 0
                return nil
            }
            
        default:
            return nil
        }
    }
}




extension JSONValue: SequenceType  {
   
    public typealias Generator  = JSONGenerator

    public func generate() -> Generator {
        
        let gen = Generator(value: self)
        return gen
    }
}
