//
//  AirportsViewModel.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 21.04.2022.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

typealias AirportItemsSection = SectionModel<Int, AirportViewModelProtocol>

protocol AirportsViewModelProtocol {
    
    typealias Output = (
        title: Driver<String>,
        airports: Driver<[AirportItemsSection]>
    )
    
    typealias Input = ()
    
    typealias Dependencies = (
        title: String,
        models: Set<Airport>
    )
    
    typealias ViewModelBuilder = (AirportsViewModelProtocol.Input) -> AirportsViewModelProtocol

    var output: AirportsViewModelProtocol.Output { get }
    var input: AirportsViewModelProtocol.Input { get }
}

struct AirportsViewModel: AirportsViewModelProtocol {
    
    var output: AirportsViewModelProtocol.Output
    var input: AirportsViewModelProtocol.Input
    
    init(input: AirportsViewModelProtocol.Input, dependencies: AirportsViewModelProtocol.Dependencies) {
        self.input = input
        self.output = AirportsViewModel.output(dependencies: dependencies)
    }
}

extension AirportsViewModel {
    
    static func output(dependencies: AirportsViewModelProtocol.Dependencies) -> AirportsViewModelProtocol.Output {
        
        let section = Driver.just(dependencies.models)
            .map {
                $0.compactMap( { AirportViewModel(usingModel: $0) } )
            }
            .map {
                [AirportItemsSection(model: 0, items: $0)]
            }
        
        return (
            title: Driver.just(dependencies.title),
            airports: section
        )
    }
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
