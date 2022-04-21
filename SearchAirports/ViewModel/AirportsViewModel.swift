//
//  AirportsViewModel.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 21.04.2022.
//

import Foundation

protocol AirportsViewModelProtocol {
    
    typealias Output = ()
    typealias Input = ()
    
    var output: AirportsViewModelProtocol.Output { get }
    var input: AirportsViewModelProtocol.Input { get }
}

struct AirportsViewModel: AirportsViewModelProtocol {
    
    var output: AirportsViewModelProtocol.Output
    var input: AirportsViewModelProtocol.Input
}



protocol AirportViewModelProtocol {
    
    var name: String { get }
    var code: String { get }
    var address: String { get }
    var distance: Double? { get }
    var formattedDistance: String { get }
    var runwayLength: String { get }
    var location: (lat: String, lon: String) { get }
}

struct AirportViewModel: AirportViewModelProtocol {
    
    var formattedDistance: String {
        return "\(distance?.rounded(.toNearestOrEven) ?? 0 / 1000) Km"
    }
    var name: String
    var code: String
    var address: String
    var distance: Double?
    var runwayLength: String
    var location: (lat: String, lon: String)
    
    init(usingModel model: Airport) {
        
        self.name = model.name
        self.code = model.code
        self.address = model.state ?? model.country
        self.name = model.name
        self.runwayLength = "Runway Length: \(model.runwayLength ?? "")"
        self.location = (lat: model.lat, lon: model.lon)
        self.distance = 0
    }
}
