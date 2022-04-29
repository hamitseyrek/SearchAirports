//
//  SearchCityCoordinator.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 19.04.2022.
//

import UIKit
import RxSwift

class SearchCityCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController?
    
    private let bagDis = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        
        navigationController?.pushViewController(view, animated: true)
    }
}

extension SearchCityCoordinator {
    
    func showAirports(usingModel models: Set<Airport>) -> Void {
        
        let airportCoordinator = AirportsCoordinator(models: models, navigationController: self.navigationController)
        self.add(coordinator: airportCoordinator)
        
        airportCoordinator.start()
    }
}
