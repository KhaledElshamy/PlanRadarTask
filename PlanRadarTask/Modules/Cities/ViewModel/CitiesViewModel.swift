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
        dataSource = cityWeatherLocalStorage?.fetchCitiesNames() ?? []
    }
}


extension CitiesViewModel:CitiesViewModelDelegate {
    
    func setCityName(to name:String) {
        self.cityName = name
    }
    
    func fetchCityWeatherDetails() {
        guard let name = cityName else {return}
        cityWeatherFetcher?.fetchCityWeather(with: name,
                                        completionHandler: { result in
            switch result {
            case .success(let model):
                break
            case .error(let error):
                break
            }
        })
//        self.dataSource.append(name)
    }
}
