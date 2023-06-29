
//  Created by Gayan Dias on 27/06/2023.

import Foundation
import Combine

protocol ArtRepository {
    
    func getArtCollections(pageCount: Int,
                           pagePageCount: Int) async -> AnyPublisher<ArtResponse,
                                                                     APIError>
    
    func getArtCollectionDetail(objectId: String) async -> AnyPublisher<ArtDetailResponse,
                                                                        APIError>
}

final class ArtRepositoryImpl: ArtRepository {
    
    private let publicNetwork: APIClient
    
    init(publicNetwork: APIClient) {
        self.publicNetwork = publicNetwork
    }
    
    func getArtCollections(pageCount: Int,
                           pagePageCount: Int) async -> AnyPublisher<ArtResponse,
                                                                     APIError> {
                                                                         let items = [URLQueryItem(name: "key",
                                                                                                   value: Constants.API.API_KEY),
                     URLQueryItem(name: "p", value: "\(pageCount)"),
                     URLQueryItem(name: "ps", value: "\(pagePageCount)")
        ]
        let request = Route(.get, .product(.getArtCollection,
                                           with: items))
        return await self.publicNetwork.request(request)
    }
    
    func getArtCollectionDetail(objectId: String) async -> AnyPublisher<ArtDetailResponse,
                                                                        APIError> {
        let items = [URLQueryItem(name: "key",
                                  value: Constants.API.API_KEY)]
        let request = Route(.get, .product(.getArtCollectionDetail(objectId: objectId),
                                           with: items))
        return await self.publicNetwork.request(request)
    }
}
