//
//  AirportsCoordinator.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 21.04.2022.
//

import UIKit
import RxSwift

class AirportsCoordinator: BaseCoordinator {
    
    private let router: Routing?
    
    private let bagDisp = DisposeBag()
    
    private let models: Set<Airport>
    
    init(models: Set<Airport>, router: Routing?) {
        self.router = router
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
        
        
        router?.push(view, isAnimated: true, onNavigationBack: isCompleted)
        
    }
}
