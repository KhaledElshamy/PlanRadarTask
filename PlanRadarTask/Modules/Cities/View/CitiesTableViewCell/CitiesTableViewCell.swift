//
//  CitiesTableViewCell.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit


protocol CitiesTableViewCellDelegate: AnyObject {
    func handleTapCityInfo(cell: CitiesTableViewCell)
}

class CitiesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var detailsArrow: UIImageView!
    
    weak var delegate:CitiesTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cityName.textColor = .black
        backgroundColor = .white
        
        detailsArrow.isUserInteractionEnabled = true 
        detailsArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToWeatherHistory)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func navigateToWeatherHistory(){
        delegate?.handleTapCityInfo(cell: self)
    }
}
