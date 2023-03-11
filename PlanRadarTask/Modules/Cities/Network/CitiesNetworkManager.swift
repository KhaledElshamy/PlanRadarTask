//
//  CitiesNetworkManager.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import Foundation

struct CityWeatherEndPoint: EndPointType {
    typealias ResponseModel = CityWeatherResponse
    
    var path: URLs.Path
    
    var httpMethod: HTTPMethod? = .get
    
    var headers: HTTPHeaders?
    
    var bodyParams: Parameters?
}


class CityWeatherNetworkManager {
    var cityWeatherEndPoint: CityWeatherEndPoint?
    
    func configure(cityName:String) {
        cityWeatherEndPoint = CityWeatherEndPoint(path: .details(city: cityName))
    }
}
