//
//  AirPort.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 20.04.2022.
//

struct Airport: Codable {
    
    let code, lat, lon, name, city, country, woeid, tz, phone, type, email, url, icao, carriers, directFlights: String
    let runwayLength, state, elev: String?
    
    enum CodingKeys: String, CodingKey {
        case code, lat, lon, name, city, country, woeid, tz, phone, type, email, url, icao, carriers
        case state, elev
        case runwayLength = "runway_length"
        case directFlights = "direct_flights"
    }
}

extension Airport: Equatable {
    
    static func == (lhs: Airport, rhs: Airport) -> Bool {
        return lhs.code == rhs.code
    }
}

extension Airport: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine (code)
    }
}

typealias Airports = [Airport]
