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
        models: Set<Airport>,
        currentLocation: Observable<(lat: Double, lon: Double)?>
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
        
        let section = Observable.just(dependencies.models)
            .withLatestFrom(dependencies.currentLocation) { ( models: $0, location: $1 )}
            .map { arg in
                arg.models.compactMap( {
                    AirportViewModel(usingModel: $0, currentLocation: arg.location ?? (lat: 0, lon: 0)) } )
                
                .sorted()
            }
            .map {
                [AirportItemsSection(model: 0, items: $0)]
            }
            .asDriver(onErrorJustReturn: [])
        
        return (
            title: Driver.just(dependencies.title),
            airports: section
        )
    }
}
