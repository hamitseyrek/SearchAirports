//
//  AirportsCoordinator.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 21.04.2022.
//

import UIKit
import RxSwift

class AirportsCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController?
    
    private let bagDisp = DisposeBag()
    
    private let models: Set<Airport>
    
    init(models: Set<Airport>, navigationController: UINavigationController?) {
        self.navigationController = navigationController
        self.models = models
    }
    
    override func start() {
        
        let view = AirportsVC.instantiate()
        let locationService = LocationService.shared
        
        view.viewModelBuilder = { [models, locationService] in
            let title = models.first?.city ?? ""
            return AirportsViewModel(
                input: $0,
                dependencies: (
                    title: title,
                    models: models,
                    currentLocation: locationService.currentLocation))
        }
        
        
        navigationController?.pushViewController(view, animated: true)
        
    }
}
