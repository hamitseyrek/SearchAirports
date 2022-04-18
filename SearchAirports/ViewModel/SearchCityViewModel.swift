//
//  SearchCityViewModel.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 18.04.2022.
//

import Foundation
import RxCocoa

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
    
    init(input: SearchCityViewModelProtocol.Input) {
        self.input = input
        self.output = SearchCityViewModel.output(input: self.input)
    }
    
}

private extension SearchCityViewModel {
    
    static func output(input: SearchCityViewModelProtocol.Input) -> SearchCityViewModelProtocol.Output {
        return ()
    }
}
