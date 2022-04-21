//
//  CityViewModel.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 21.04.2022.
//

import Foundation

import RxDataSources
typealias CityItemsSection = SectionModel<Int, CityViewModelProtocol>

protocol CityViewModelProtocol {
    var city: String { get }
    var location: String { get }
}

struct CityViewModel: CityViewModelProtocol {
    
    var city: String
    var location: String
    
    init(model: Airport) {
        
        self.city = model.city
        self.location = "\(model.state ?? ""), \(model.country)"
    }
}

extension CityViewModel: Equatable {
    
    static func == (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        return lhs.city == rhs.city
    }
}

extension CityViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine (city)
    }
}
