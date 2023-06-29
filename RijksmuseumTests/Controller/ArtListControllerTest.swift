
//  Created by Gayan Dias on 28/06/2023.

import XCTest
import Alamofire
@testable import Rijksmuseum

final class ArtListControllerTest: XCTestCase {
    
    var viewController: ArtListViewController?
    var viewModel: ArtListViewModel?
    
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
        
        viewController = ArtListViewController(nibName: nil, bundle: nil)
        viewController?.viewModel = ArtListViewModel(repository: artRepository,
                                                     coordinator: coordinator)
        viewModel = viewController?.viewModel
    }
    
    func testViewControllerInitialisation() {
        
        XCTAssertNotNil(viewController)
    }

    func testViewModelInitialisation() {
        
        XCTAssertNotNil(viewModel)
    }
    
    func testNavigateToDetail() {
        viewModel?.navigateToDetail(artItem: artItem())
    }
}

extension ArtListControllerTest {
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
