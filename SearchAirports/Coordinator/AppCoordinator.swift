//
//  AppCoordinator.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 19.04.2022.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primaryColor")
        
        // setup title font color
        let titleAttribute = [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 28.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = titleAttribute
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.isTranslucent = false

        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        let router = Router(navigationController: self.navigationController)
        let searchCityCoordinator = SearchCityCoordinator(router: router)
        self.add(coordinator: searchCityCoordinator)
        
        searchCityCoordinator.isCompleted = { [weak self, weak searchCityCoordinator] in
            if let coordinator = searchCityCoordinator {
                self?.remove(coordinator: coordinator)
            }
        }
        
        searchCityCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
