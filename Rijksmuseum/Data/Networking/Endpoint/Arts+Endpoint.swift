
//  Created by Gayan Dias on 27/06/2023.

import Foundation

extension Endpoint {
    
    static func product(_ art: Art, with queryItems: [URLQueryItem]? = nil) -> Endpoint {
        .Rijksmuseum(path: art.path, with: queryItems)
    }
    
    enum Art {
        
        case getArtCollection
        case getArtCollectionDetail(objectId: String)
        
        var path: String {
            switch self {
                
            case .getArtCollection:
                return "/api/nl/collection/"
            case .getArtCollectionDetail(let objectId):
                return "/api/nl/collection/\(objectId)"
            }
        }
    }
}
