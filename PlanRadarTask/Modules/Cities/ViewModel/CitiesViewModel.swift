//
//  CitiesViewModel.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit
import Combine

protocol CitiesViewModelDelegate {
    func fetchCityWeatherDetails()
    func setCityName(to name:String)
}

class CitiesViewModel {
    
    @Published var dataSource: [String] = []
    private var cityName: String?
    private var cityWeatherFetcher:CityWeatherFetcherDelegate?
    private var cityWeatherLocalStorage:CityWeatherLocalStorrageDelegate?
    
    init(cityWeatherLocalStorage:CityWeatherLocalStorrageDelegate,cityWeatherFetcher:CityWeatherFetcherDelegate){
        self.cityWeatherFetcher = cityWeatherFetcher
        self.cityWeatherLocalStorage = cityWeatherLocalStorage
        
        LoadCitiesFromLocalStorage()
    }
    
    private func LoadCitiesFromLocalStorage(){
        dataSource = cityWeatherLocalStorage?.getCitiesNames() ?? []
    }
}


extension CitiesViewModel:CitiesViewModelDelegate {
    
    func setCityName(to name:String) {
        self.cityName = name
    }
    
    func fetchCityWeatherDetails() {
        guard let name = cityName else {return}
        cityWeatherFetcher?.fetchCityWeather(with: name,
                                        completionHandler: { [weak self] result in
            switch result {
            case .success(let model):
                let city = self?.getCityModel(model: model)
                self?.cityWeatherLocalStorage?.addWeather(for: city!)
                self?.dataSource = self?.cityWeatherLocalStorage?.getCitiesNames() ?? []
                break
            case .error(let error):
                break
            }
        })
    }
    
    private func getCityModel(model:CityWeatherResponse) -> City {
        let baseURL = ConfigurationManager.baseURL
        let imageURL = baseURL + (URLs.Path.weatherIcon(iconId: model.weather?.first?.icon ?? "").absolutePath)
        return City(name: self.cityName ?? "",
                    description: model.weather?.first?.description ?? "",
                    humidity: "\(model.main?.humidity ?? 0)",
                    windSpeed: "\(model.wind?.speed ?? 0)",
                    temperature: "\(model.main?.temprature ?? 0.0)",
                    imageURL: imageURL)
    }
}
