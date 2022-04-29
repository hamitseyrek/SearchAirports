//
//  DetailVC.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 21.04.2022.
//

import UIKit
import RxSwift
import RxDataSources

class AirportsVC: UIViewController, Storyboardable {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: AirportsViewModelProtocol!
    var viewModelBuilder: AirportsViewModelProtocol.ViewModelBuilder!
    
    private let bag = DisposeBag()
    
    private static let cellID = "AirportCellID"
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<AirportItemsSection> { ds, tv, ip, item in
        
        let cell = tv.dequeueReusableCell(withIdentifier: AirportsVC.cellID, for: ip) as! AirportTableViewCell
        cell.configure(usingViewModel: item)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = viewModelBuilder(())
        self.setupUI ()
        self.setupBinding ()
    }
}
private extension AirportsVC {
    
    func setupUI () -> Void {
        
        tableView.register (UINib(nibName: "AirportTableViewCell", bundle: nil),
                            forCellReuseIdentifier: AirportsVC.cellID)
    }
    
    func setupBinding() -> Void {
        
        self.viewModel.output.airports.drive(tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: bag)
        
        self.viewModel.output.title
            .drive(self.rx.title)
            .disposed (by: bag)
    }
}
