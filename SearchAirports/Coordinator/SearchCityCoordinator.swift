//
//  SearchCityCoordinator.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 19.04.2022.
//

import UIKit

class SearchCityCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        
        let view = SearchCityVC.instantiate()
        
        view.viewModelBuilder = {
            SearchCityViewModel.init(input: $0)
        }
        
        navigationController?.pushViewController(view, animated: true)
    }
}
