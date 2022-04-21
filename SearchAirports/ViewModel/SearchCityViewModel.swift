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
        searchText: Driver<String>,
        citySelect: Driver<CityViewModel>
    )
    
    typealias Output = ( cities: Driver<[CityItemsSection]>, () )
    
    typealias ViewModelBuilder = (SearchCityViewModelProtocol.Input) -> SearchCityViewModelProtocol
    
    var input: SearchCityViewModelProtocol.Input { get }
    var output: SearchCityViewModelProtocol.Output { get }
    
}

class SearchCityViewModel: SearchCityViewModelProtocol {
    
    var input: SearchCityViewModelProtocol.Input
    var output: SearchCityViewModelProtocol.Output
    private let airportsService: ApiServiceProtocol
    private let bagDispose = DisposeBag()
    
    // for CitySearcVC
    typealias State = (airports: BehaviorRelay<Set<Airport>>, ())
    private let state: State = (airports: BehaviorRelay<Set<Airport>>(value: []), ())
    
    // for AirportsVC
    private typealias RoutingAction = (citySelectedRelay: PublishRelay<Set<Airport>>, ())
    private let routingAction: RoutingAction = (citySelectedRelay: PublishRelay(), ())
    typealias Routing = (citySelected: Driver<Set<Airport>>, ())
    lazy var routing: Routing = (citySelected: routingAction.citySelectedRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: SearchCityViewModelProtocol.Input, airportsService: ApiServiceProtocol) {
        self.input = input
        self.output = SearchCityViewModel.output(input: self.input, state: self.state)
        self.airportsService = airportsService
        self.process()
    }
    
}

private extension SearchCityViewModel {
    
    static func output(input: SearchCityViewModelProtocol.Input, state: State) -> SearchCityViewModelProtocol.Output {
        
        let searchTextObservable = input.searchText
            .debounce(.microseconds(300))
            .distinctUntilChanged()
            .skip(1)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        let airportsObservable = state.airports
            .skip(1)
            .asObservable()
        
        let sections = Observable.combineLatest(searchTextObservable, airportsObservable)
            .map { (searchKey, airports) in
                
                return airports.filter { (airport) -> Bool in
                    !searchKey.isEmpty &&
                    airport.city
                        .lowercased()
                        .replacingOccurrences(of: " ", with: "")
                        .hasPrefix(searchKey.lowercased())
                }
            }
            .map { airports in
                SearchCityViewModel.uniqueelementsFrom(array: airports.compactMap({ airport in
                    CityViewModel(model: airport)
                }))
            }
            .map({ [CityItemsSection(model: 0, items: $0)] })
            .asDriver(onErrorJustReturn: [])
        
        return (cities: sections, ())
    }
    
    func process() -> Void {
        
        self.airportsService
            .fetchAirports()
            .map({ Set($0) })
            .map({ [state] in state.airports.accept($0) })
            .subscribe()
            .disposed(by: bagDispose)
        
        self.input.citySelect.map({ $0.city })
        .withLatestFrom(state.airports.asDriver()) { ($0, $1) }
        .map { (city, airports) in
            airports.filter({ $0.city == city })
        }
        .map({ [routingAction] in
            routingAction.citySelectedRelay.accept($0)
        })
        .drive()
        .disposed(by: bagDispose)
    }
}

private extension SearchCityViewModel {
    
    static func uniqueelementsFrom(array: [CityViewModel]) -> [CityViewModel] {
        
        var set = Set<CityViewModel>()
        let result = array.filter {
            
            guard !set.contains($0) else {
                return false
            }
            
            set.insert($0)
            
            return true
        }
        
        return result
    }
}
