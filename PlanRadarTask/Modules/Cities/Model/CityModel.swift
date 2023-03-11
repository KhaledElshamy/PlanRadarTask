//
//  CityModel.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import Foundation

struct City {
    
    // MARK: - Properties
    var name: String
    var description: String
    var humidity: String
    var windSpeed: String
    var temperature: String
    var imageURL: String
    var timeTemp: Date?

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: timeTemp ?? Date())
    }
}
