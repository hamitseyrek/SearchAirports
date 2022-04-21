//
//  ViewController.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 18.04.2022.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCityVC: UIViewController, Storyboardable {    

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var viewModel: SearchCityViewModelProtocol!
    var viewModelBuilder: SearchCityViewModelProtocol.ViewModelBuilder!
    
    private static let CellID = "CityCellID"
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<CityItemsSection> { ds, tv, ip, item in
        
        let cell: CityTableViewCell = tv.dequeueReusableCell(withIdentifier: SearchCityVC.CellID, for: ip) as! CityTableViewCell
        cell.configure(usingViewModel: item)
        return cell
    }
    
    private let bag2 = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Airports"
        // Do any additional setup after loading the view.
        viewModel = viewModelBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(),
            citySelect: tableView.rx.modelSelected(CityViewModel.self).asDriver()
    ))
        
        setupUI()
        setupBinding()
    }
}

private extension SearchCityVC {
    
    func setupUI() -> Void {
        
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: SearchCityVC.CellID)
        self.title = "Airports1"
    }
    
    func setupBinding() -> Void {
        self.viewModel.output.cities.drive(tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: bag2)
    }
}

