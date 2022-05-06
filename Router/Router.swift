//
//  Router.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 6.05.2022.
//

import Foundation
import UIKit

final class Router {
    
    private let navigationController: UINavigationController
    private var closures: [ String: NavigationBackClosure ] = [ : ]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension Router: RouterProtocol {
    
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack closure: NavigationBackClosure?) {
        
        guard let viewController = drawable.viewController else { return }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
     
}
