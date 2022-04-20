//
//  SearchCityViewModel.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 18.04.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol SearchCityViewModelProtocol {
    
    typealias Input = (
        searchText: Driver<String>, ()
    )
    typealias Output = ()
    typealias ViewModelBuilder = (SearchCityViewModelProtocol.Input) -> SearchCityViewModelProtocol
    
    var input: SearchCityViewModelProtocol.Input { get }
    var output: SearchCityViewModelProtocol.Output { get }
    
}

class SearchCityViewModel: SearchCityViewModelProtocol {
    
    var input: SearchCityViewModelProtocol.Input
    var output: SearchCityViewModelProtocol.Output
    private let airportsService: ApiServiceProtocol
    private let bagDispose = DisposeBag()
    
    init(input: SearchCityViewModelProtocol.Input, airportsService: ApiServiceProtocol) {
        self.input = input
        self.output = SearchCityViewModel.output(input: self.input)
        self.airportsService = airportsService
        self.process()
    }
    
}

private extension SearchCityViewModel {
    
    static func output(input: SearchCityViewModelProtocol.Input) -> SearchCityViewModelProtocol.Output {
        return ()
    }
    
    func process() -> Void {
        self.airportsService
            .fetchAirports()
            .map({ result in
                print("AirPorts: \(result[10])")
            })
            .subscribe()
            .disposed(by: bagDispose)
    }
}
