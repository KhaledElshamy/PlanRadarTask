//
//  CityDetailsViewController.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import UIKit
import PINRemoteImage

class CityDetailsViewController: BaseVC<CityDetailsView> {
    
    // MARK: - Proporties
    private var model: City
    
    // MARK: -  Life Cycle
    init(model: City) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCityWeatherDetails()
        
        mainView.cancelCrossButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    private func setCityWeatherDetails(){
        mainView.titleLabel.text = model.name
        mainView.bottomDescription.text = "Weather information for \(model.name) received on \(model.dateString) "
        mainView.descriptionLabel.text = " DESCRIPTION: " + model.description
        mainView.temperatureLabel.text =  " TEMPERATURE: " + model.temperature
        mainView.humidityLabel.text =  " HUMIDITY: " + model.humidity
        mainView.windSpeedLabel.text = " WINDSPEED: " + model.windSpeed
        mainView.weatherImage.loadImage(url: model.imageURL)
    }
    
    @objc private func dismissView(){
        dismiss(animated: true)
    }
}
