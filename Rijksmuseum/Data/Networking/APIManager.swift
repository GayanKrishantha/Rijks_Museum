
//  Created by Gayan Dias on 27/06/2023.

import Alamofire
import Foundation
import Combine

final class APIManager: APIClient {
    
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    /// Request
    func request<T: Decodable>(_ request: URLRequestConvertible,
                               decoder: JSONDecoder,
                               interceptor: RequestInterceptor?) -> AnyPublisher<T, APIError> {
        return Future<T, APIError> { [weak self] promise in
            
            self?.session
                .request(request, interceptor: interceptor)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self, decoder: decoder) { response in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(let error):
                        guard !error.isTimeout else {return promise(.failure(.timeout)) }
                        guard !error.isConnectedToTheInternet else { return promise(.failure(.noNetwork)) }
                        return promise(.failure(.statusMessage(message: error.localizedDescription)))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
