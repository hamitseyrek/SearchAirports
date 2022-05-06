//
//  Drawable.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 6.05.2022.
//

import Foundation
import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    
    var viewController: UIViewController? {
        return self
    }
}
