
//  Created by Gayan Dias on 28/06/2023.

import XCTest
import Alamofire
@testable import Rijksmuseum

class ArtDetailControllerTest: XCTestCase {
    
    var viewController: ArtDetailViewController?
    var viewModel: ArtDetailViewModel?
    
    override func setUp() {
        super.setUp()
        
        let dependencyContainer = DependencyContainer()
        let navigationController = RijkNavigationController(style: .opaque)
        let publicNetwork: APIClient = APIManager(session: Session())
        let artRepository: ArtRepository = ArtRepositoryImpl(publicNetwork: publicNetwork)
        
        let coordinator = AppCoordinatorImpl(
            dependencyContainer: dependencyContainer,
            navigationController: navigationController
        )
        
        viewController = ArtDetailViewController(nibName: nil, bundle: nil)
        viewController?.viewModel = ArtDetailViewModel(repository: artRepository,
                                                       coordinator: coordinator,
                                                       artItem: self.artItem())
        viewModel = viewController?.viewModel
    }
    
    func testViewControllerInitialisation() {
        
        XCTAssertNotNil(viewController)
    }
    
    func testViewModelInitialisation() {
        
        XCTAssertNotNil(viewModel)
    }
}

extension ArtDetailControllerTest {
    
    func artItem() -> Art {
        return Art(id: "nl-BK-AM-33-C",
                   objectNumber: "BK-AM-33-C",
                   title: "Tien pleurants van het praalgraf van Isabella van Bourbon",
                   hasImage: true,
                   principalOrFirstMaker: "Borman werkplaats, Renier van Thienen (I)",
                   longTitle: "Tien pleurants van het praalgraf van Isabella van Bourbon",
                   showImage: true,
                   permitDownload: true,
                   webImage: WebImage(guid: "b0e1c132-8ba4-4796-a12a-e351adb594d1",
                                      url: "https://lh5.ggpht.com/EHhJDrv4IB_89m9w9VlcYRYHYOuvU72iwD11o"),
                   headerImage: HeaderImage(guid: "b0e1c132-8ba4-4796-a12a-e351adb594d1",
                                            url: "https://lh5.ggpht.com/EHhJDrv4IB_89m9w9VlcYRYHYOuvU72iwD11o"),
                   productionPlaces: ["Brussel (stad)"])
    }
}
