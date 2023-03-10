//
//  URLs.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import Foundation

struct URLs  {
    enum Path {
        
        case details(city: String)
        case weatherIcon(iconId: String)
        
        var absolutePath: String {
            switch self {
            case .details(let cityName):
                return "/data/2.5/weather?q=\(cityName)&appid=f5cb0b965ea1564c50c6f1b74534d823"
            case .weatherIcon(let iconId):
                return "/img/w/\(iconId).png"
                
            }
        }
    }
}
