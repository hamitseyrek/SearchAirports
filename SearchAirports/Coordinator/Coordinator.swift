//
//  Coordinator.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 19.04.2022.
//

protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    
    func add(coordinator: Coordinator) -> Void {
        self.childCoordinator.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) -> Void {
        self.childCoordinator = self.childCoordinator.filter( { $0 !== coordinator })
    }
}
