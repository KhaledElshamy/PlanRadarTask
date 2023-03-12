//
//  CityWeatherLocalStorage.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import Foundation
import CoreData

protocol CityWeatherLocalStorrageDelegate {
    func getCitiesNames() -> [String]
    func addWeather(for city:City)
    func deleteCity(with index: Int)
    func getCityDetails(at index: Int) -> [City]
}


class CityWeatherLocalStorage {
    
    let managedObjectContext: NSManagedObjectContext
    private var dataController:DataController?
    
    private var cities: [CityModel] = []
    
    init(dataController:DataController, managedObjectContext:NSManagedObjectContext){
        self.dataController = dataController
        self.managedObjectContext = managedObjectContext
        loadLocalCities()
    }
    
    private func loadLocalCities(){
        do {
            guard let dataController = self.dataController else {return}
            cities = try dataController.mainContext.fetch(CityModel.fetchRequest())
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    private func getCityIndex(name: String) -> Int? {
        return cities.firstIndex(where: {$0.name == name})
    }
}


extension CityWeatherLocalStorage: CityWeatherLocalStorrageDelegate {
    
    func getCitiesNames() -> [String] {
        return cities.map {$0.name}
    }
    
    func addWeather(for city: City) {
        if let cityIndex = getCityIndex(name: city.name) {
            saveCityWeather(for: city, index: cityIndex)
        }else {
            addNewCity(city)
        }
    }
    
    private func addNewCity(_ model: City) {
        if let dataController = self.dataController {
            let city = CityModel(context: managedObjectContext)
            city.name = model.name
            let weather = getWeatherInfoModel(for:model)
            weather?.city = city
            dataController.saveContext()
            
            cities.append(city)
        }
    }
    
    private func saveCityWeather(for cityModel: City, index: Int) {
        let city = cities[index]
        let weather = getWeatherInfoModel(for: cityModel)
        weather?.city = city
        dataController?.saveContext()
    }
    
    private func getWeatherInfoModel(for model: City) -> WeatherInfoModel? {
        let weather = WeatherInfoModel(context: managedObjectContext)
        weather.humidity = model.humidity
        weather.imageURL = model.imageURL
        weather.wind =  model.windSpeed
        weather.temperature = model.temperature
        weather.descriptionInfo = model.description
        weather.timeTemp = Date()
        return weather
    }
    
    func deleteCity(with index: Int) {
        let city = cities[index]
        managedObjectContext.delete(city)
        dataController?.saveContext()
    }
    
    func getCityDetails(at index: Int) -> [City] {
        loadLocalCities()
        let city = cities[index]
        let weathers = city.weathers
        let models: [City] = weathers.map({
            City(name: city.name, description: $0.descriptionInfo, humidity: $0.humidity, windSpeed: $0.wind, temperature: $0.temperature, imageURL: $0.imageURL, timeTemp: $0.timeTemp)
            
        })
        let orderModel = models.sorted { a, b in
            a.timeTemp!  > b.timeTemp!
        }
        return orderModel
    }
}
