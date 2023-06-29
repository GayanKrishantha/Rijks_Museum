
//  Created by Gayan Dias on 27/06/2023.

import UIKit

protocol AppCoordinator: AnyObject {
    func start()
    func showDetail(artItem: Art)
    func back()
}

final class AppCoordinatorImpl: AppCoordinator {
    
    private let dependencyContainer: DependencyContainer
    
    private unowned var navigationController: UINavigationController = {
        let navigationController = RijkNavigationController(style: .opaque(tintColor: .clear))
        return navigationController
    }()
    
    init(dependencyContainer: DependencyContainer,
         navigationController: RijkNavigationController) {
        self.dependencyContainer = dependencyContainer
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ArtListViewModel(repository: dependencyContainer.artRepository,
                                         coordinator: self)
        let viewController = ArtListViewController()
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController],
                                                animated: false)
    }
    
    func showDetail(artItem: Art) {
        let viewModel = ArtDetailViewModel(repository: dependencyContainer.artRepository,
                                                     coordinator: self,
                                           artItem: artItem)
        let viewController = ArtDetailViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
