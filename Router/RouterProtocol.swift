//
//  RouterProtocol.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 6.05.2022.
//

import Foundation

typealias NavigationBackClosure = (() -> ())

protocol RouterProtocol {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
}
