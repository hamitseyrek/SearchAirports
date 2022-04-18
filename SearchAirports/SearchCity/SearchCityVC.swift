//
//  ViewController.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 18.04.2022.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCityVC: UIViewController {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UIView!
    
    var viewModel: SearchCityViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

