//
//  ApiService.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 20.04.2022.
//

import RxSwift
import Alamofire

protocol ApiServiceProtocol {
    func fetchAirports() -> Single<Airports>
}

class ApiService {
    static let shared: ApiService = ApiService()
}

extension ApiService: ApiServiceProtocol {
    
    func fetchAirports() -> Single<Airports> {
        return Single.create { (single) -> Disposable in
            
            AF.request(ApiRouter.AirPortsPath.withBaseUrl(), method: .get).validate().responseDecodable(of: [Airport].self) { response in
                guard let data = response.value else {
                    //print("Error is here: ", response.error?.localizedDescription ?? "")
                    single(.failure(NetworkError.error(message: response.error?.localizedDescription ?? "Something went wrong")))
                    return
                }
                
                single(.success(data))
            }
            return Disposables.create()
        }
    }
}
