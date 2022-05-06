//
//  SearchCityCoordinator.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 19.04.2022.
//

import UIKit
import RxSwift

class SearchCityCoordinator: BaseCoordinator {
    
    private let router: Routing?
    
    private let bagDis = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        
        let view = SearchCityVC.instantiate()
        let service = ApiService.shared
        
        view.viewModelBuilder = { [bagDis] in
            let viewModel = SearchCityViewModel.init(input: $0, airportsService: service)
            
            viewModel.routing.citySelected
                .map { [weak self] airports in
                    guard let self = self else { return }
                    self.showAirports(usingModel: airports)
                }
                .drive()
                .disposed(by: bagDis)
            
            return viewModel
        }
        
        router?.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

extension SearchCityCoordinator {
    
    func showAirports(usingModel models: Set<Airport>) -> Void {
        
        let airportCoordinator = AirportsCoordinator(models: models, router: self.router)
        self.add(coordinator: airportCoordinator)
        
        airportCoordinator.isCompleted = { [weak self, weak airportCoordinator] in
            if let coordinator = airportCoordinator {
                self?.remove(coordinator: coordinator)
            }
        }
        
        airportCoordinator.start()
    }
}
