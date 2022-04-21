//
//  AirportTableViewCell.swift
//  SearchAirports
//
//  Created by Hamit Seyrek on 22.04.2022.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var runwayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(usingViewModel viewModel: AirportViewModelProtocol) {
        
        self.airportNameLabel.text = viewModel.name
        self.distanceLabel.text = String(describing: viewModel.distance)
        self.countryLabel.text = viewModel.address
        self.runwayLabel.text = viewModel.runwayLength
        
        self.selectionStyle = .none
    }
    
}
