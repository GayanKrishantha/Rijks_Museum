
//  Created by Gayan Dias on 27/06/2023.

enum APIError : Error {
    
    case general
    case timeout
    case pageNotFound
    case noData
    case noNetwork
    case unknownError
    case serverError
    case statusMessage(message : String)
    case decodeError(String)
}

extension APIError {
    var desc: String {
        
        switch self {
        case .general:
            return MessageHelper.serverError.general
        case .timeout:
            return MessageHelper.serverError.timeOut
        case .pageNotFound:
            return MessageHelper.serverError.notFound
        case .noData:
            return MessageHelper.serverError.notFound
        case .noNetwork:
            return MessageHelper.serverError.noInternet
        case .unknownError:
            return MessageHelper.serverError.general
        case .serverError:
            return MessageHelper.serverError.serverError
        case .statusMessage(let message):
            return message
        case .decodeError(let error):
            return error
        }
    }
}

struct MessageHelper {
    
    /// General Message Handler
    struct serverError {
        static let general : String = L10n.Error.general
        static let noInternet : String = L10n.Error.noInternet
        static let timeOut : String = L10n.Error.timeOut
        static let notFound : String = L10n.Error.notFound
        static let serverError : String = L10n.Error.serverError
    }
}
