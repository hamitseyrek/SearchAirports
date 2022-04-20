//
//  ApiRouter.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 20.04.2022.
//

enum ApiRouter: String {
    case AirPortsPath = "/airports.json"
}

extension ApiRouter {
    
    func withBaseUrl() -> String {
        return "https://raw.githubusercontent.com/hamitseyrek/SearchAirports/hamitseyrek\(self.rawValue)"
    }
}
