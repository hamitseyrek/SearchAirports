//
//  BaseCoordinator.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 19.04.2022.
//

class BaseCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    func start() {
        fatalError("Children should implement 'start'")
    }
}
