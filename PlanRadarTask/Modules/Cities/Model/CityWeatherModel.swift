//
//  CityWeatherModel.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import Foundation
import ObjectMapper

// MARK: - DailyTreasuryModel
struct CityWeatherResponse: Mappable  {
    
    // MARK: - Properties
    
    var weather: [Weather]?
    var main: Main?
    var wind: Wind?
    var timezone: Int?
    // MARK: - Initializer
    
    init?(map: Map) {}
    
    init(weather: [Weather]?, main: Main?, wind: Wind?, timezone: Int?) {
        self.weather = weather
        self.main = main
        self.wind = wind
        self.timezone = timezone
    }
    
    // MARK: - Mapping Methods
    
    mutating func mapping(map: Map) {
        weather <- map["weather"]
        main <- map["main"]
        wind <- map["wind"]
        timezone <- map["timezone"]
    }
}

struct Weather: Mappable {
    
    // MARK: - Properties
    
    var description: String?
    var icon: String?
    
    // MARK: - Initializer
    
    init?(map: Map) {}
    
    init(description: String?, icon: String?) {
        self.description = description
        self.icon = icon
    }
    
    // MARK: - Mapping Methods
    
    mutating func mapping(map: Map) {
        description <- map["description"]
        icon <- map["icon"]
    }
}

struct Main: Mappable {
    
    // MARK: - Properties
    
    var temprature: Double?
    var humidity: Int?
    
    // MARK: - Initializer
    
    init?(map: Map) {}
    
    init(temprature: Double?, humidity: Int?) {
        self.temprature = temprature
        self.humidity = humidity
    }
    
    // MARK: - Mapping Methods
    
    mutating func mapping(map: Map) {
        temprature <- map["temp"]
        humidity <- map["humidity"]
    }
}

struct Wind: Mappable {
    
    // MARK: - Properties
    
    var speed: Double?
    
    // MARK: - Initializer
    
    init?(map: Map) {}
    
    init(speed: Double?) {
        self.speed = speed
    }
    
    // MARK: - Mapping Methods
    
    mutating func mapping(map: Map) {
        speed <- map["speed"]
    }
}
