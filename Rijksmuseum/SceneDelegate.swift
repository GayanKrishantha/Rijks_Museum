
//  Created by Gayan Dias on 27/06/2023.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            window = setupKeyWindow(in: windowScene)
        }
    }
    
    func setupKeyWindow(in scene: UIWindowScene) -> UIWindow {
        let dependencyContainer = DependencyContainer()
        let navigationController = RijkNavigationController(style: .opaque)
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let coordinator = AppCoordinatorImpl(
            dependencyContainer: dependencyContainer,
            navigationController: navigationController
        )
        coordinator.start()
        
        return window
    }
}

