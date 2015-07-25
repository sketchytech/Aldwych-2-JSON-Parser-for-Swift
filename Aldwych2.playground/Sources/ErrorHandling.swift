import Foundation

public func errorString(error err:ErrorType) -> String {
    if let e = err as? JSONError {
        switch e {
        case .FileError (let error):
            return error
        case .DataError (let error):
            return error
        case .JSONValueError (let error):
            return error
        case .URLError(let error):
            return error
        }
    }
    else {
        return (err as NSError).description
    }
    
}
