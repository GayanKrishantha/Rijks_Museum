//
//  APIClient.swift

//  Created by Gayan Dias on 27/06/2023.

import Alamofire
import Foundation
import Combine

protocol APIClient: AnyObject {
    
    /// Request
    func request<T: Decodable>(_ request: URLRequestConvertible,
                               decoder: JSONDecoder,
                               interceptor: RequestInterceptor?) async -> AnyPublisher<T, APIError>
}

extension APIClient {
    
    /// Request
    func request<T: Decodable>(_ request: URLRequestConvertible,
                               decoder: JSONDecoder = JSONDecoder(),
                               interceptor: RequestInterceptor? = nil ) async -> AnyPublisher<T, APIError> {
        await self.request(request, decoder: decoder, interceptor: nil)
    }
}
