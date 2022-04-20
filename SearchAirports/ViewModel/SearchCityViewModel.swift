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
    
    typealias State = (airports: BehaviorRelay<Set<Airport>>, ())
    private let state: State = (airports: BehaviorRelay<Set<Airport>>(value: []), ())
    
    init(input: SearchCityViewModelProtocol.Input, airportsService: ApiServiceProtocol) {
        self.input = input
        self.output = SearchCityViewModel.output(input: self.input, state: self.state, bag: self.bagDispose)
        self.airportsService = airportsService
        self.process()
    }
    
}

private extension SearchCityViewModel {
    
    static func output(input: SearchCityViewModelProtocol.Input, state: State, bag: DisposeBag) -> SearchCityViewModelProtocol.Output {
        
        let searchTextObservable = input.searchText
            .debounce(.microseconds(300))
            .distinctUntilChanged()
            .skip(1)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        let airportsObservable = state.airports
            .skip(1)
            .asObservable()
        
        Observable.combineLatest(searchTextObservable, airportsObservable)
            .map { (searchKey, airports) in
                
                return airports.filter { (airport) -> Bool in
                    !searchKey.isEmpty &&
                    airport.city
                        .lowercased()
                        .replacingOccurrences(of: " ", with: "")
                        .hasPrefix(searchKey.lowercased())
                }
            }
            .map { print($0) }
            .subscribe()
            .disposed(by: bag)
        
        return ()
    }
    
    func process() -> Void {
        self.airportsService
            .fetchAirports()
            .map({ Set($0) })
            .map({ [state] in state.airports.accept($0) })
            .subscribe()
            .disposed(by: bagDispose)
    }
}
