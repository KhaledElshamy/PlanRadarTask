//
//  CityWeatherLocalStorage.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import Foundation


protocol CityWeatherLocalStorrageDelegate {
    func fetchCitiesNames() -> [String]
}


class CityWeatherLocalStorage {
    
    private var dataController:DataController?
    private var cities: [CityModel] = []
    
    init(dataController:DataController){
        self.dataController = dataController
        loadLocalCities()
    }
    
    private func loadLocalCities(){
        do {
            guard let dataController = self.dataController else {return}
            cities = try dataController.viewContext.fetch(CityModel.fetchRequest())
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}


extension CityWeatherLocalStorage: CityWeatherLocalStorrageDelegate {
    
    func fetchCitiesNames() -> [String] {
        return cities.map {$0.name}
    }
}
