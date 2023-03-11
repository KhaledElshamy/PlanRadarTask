//
//  CitiesTableViewCell.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var detailsArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cityName.textColor = .black
        backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
