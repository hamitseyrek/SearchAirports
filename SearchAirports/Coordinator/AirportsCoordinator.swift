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
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        
        let view = AirportsVC.instantiate()
        navigationController?.pushViewController(view, animated: true)

    }
}
