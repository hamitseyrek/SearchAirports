//
//  AirportViewModel.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 1.05.2022.
//

import Foundation
import CoreLocation


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
    
    init(usingModel model: Airport, currentLocation: (lat: Double, lon: Double)) {
        
        self.name = model.name
        self.code = model.code
        self.address = model.state ?? model.country
        self.name = model.name
        self.runwayLength = "Runway Length: \(model.runwayLength ?? "")"
        self.location = (lat: model.lat, lon: model.lon)
        self.distance = AirportViewModel.getDistance(airportLocation: (lat: Double(model.lat), lon: Double(model.lon)), currentLocation: currentLocation)
    }
}

private extension AirportViewModel {
    static func getDistance (airportLocation: (lat: Double?, lon: Double?),
                              currentLocation: (lat: Double, lon: Double)) -> Double? {
        guard
            let airportLat = airportLocation.lat,
            let airportLon = airportLocation.lon else { return nil }
        let current = CLLocation (latitude: currentLocation.lat,
                                  longitude: currentLocation.lon)
        
         let airport = CLLocation(latitude: airportLat, longitude: airportLon)
        
        return current.distance (from: airport)
    }
}
