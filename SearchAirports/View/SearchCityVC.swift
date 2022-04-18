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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Airports"
        // Do any additional setup after loading the view.
        viewModel = viewModelBuilder((searchText: searchTextField.rx.text.orEmpty.asDriver(), ()))
    }


}

