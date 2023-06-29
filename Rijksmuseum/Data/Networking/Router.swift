
//  Created by Gayan Dias on 27/06/2023.

import Alamofire
import Foundation

struct Route<Parameters>: URLRequestConvertible {
    
    private var method: HTTPMethod
    private var endpoint: Endpoint
    private var parameters: Parameters?
    private var headers: HTTPHeaders?
    private var jsonEncoder: JSONEncoder?
    
    typealias RequestModifier = (inout URLRequest) throws -> Void
    private var requestModifier: RequestModifier?
    
    init(
        _ method: HTTPMethod,
        _ endpoint: Endpoint,
        with parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        requestModifier: RequestModifier? = nil
    ) where Parameters == Alamofire.Parameters {
        self.method = method
        self.endpoint = endpoint
        self.parameters = parameters
        self.headers = headers
        self.requestModifier = requestModifier
    }
    
    init<T: Encodable>(
        _ method: HTTPMethod,
        _ endpoint: Endpoint,
        with parameters: T,
        encoder: JSONEncoder? = nil,
        headers: HTTPHeaders? = nil,
        requestModifier: RequestModifier? = nil
    ) where Parameters == AnyEncodable {
        self.method = method
        self.endpoint = endpoint
        self.parameters = AnyEncodable(parameters)
        self.jsonEncoder = encoder
        self.headers = headers
        self.requestModifier = requestModifier
    }
    
    private var encoder: ParameterEncoder {
        switch method {
        case .get, .delete, .head:
            return URLEncodedFormParameterEncoder.default
        default:
            if let encoder = jsonEncoder {
                return JSONParameterEncoder(encoder: encoder)
            } else {
                return JSONParameterEncoder.default
            }
        }
    }
    
    private var encoding: ParameterEncoding {
        switch method {
        case .get, .delete, .head:
            return URLEncoding(
                destination: .methodDependent,
                arrayEncoding: .noBrackets,
                boolEncoding: .literal
            )
        default:
            return JSONEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(
            url: endpoint,
            method: method,
            headers: headers
        )
        
        try requestModifier?(&request)
        
        switch parameters {
        case let parameters as AnyEncodable:
            return try encoder.encode(parameters, into: request)
            
        case let parameters as Alamofire.Parameters:
            return try encoding.encode(request, with: parameters)
            
        default:
            return request
        }
    }
}

struct AnyEncodable: Encodable {
    
    private var encodable: Encodable
    
    init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
