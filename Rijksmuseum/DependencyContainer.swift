
//  Created by Gayan Dias on 27/06/2023.

import Alamofire

final class DependencyContainer {
    
    private lazy var publicSession = Session()
    
    private lazy var publicNetwork: APIClient = APIManager(
        session: publicSession
    )
    
    private(set) lazy var artRepository: ArtRepository = ArtRepositoryImpl(
        publicNetwork: publicNetwork
    )
}
