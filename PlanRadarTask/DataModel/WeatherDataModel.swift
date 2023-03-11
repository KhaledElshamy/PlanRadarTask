//
//  WeatherDataModel.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import CoreData

@objc(WeatherInfoModel)
final class WeatherInfoModel: NSManagedObject  {
    
    @NSManaged var descriptionInfo: String
    @NSManaged var humidity: String
    @NSManaged var imageURL: String
    @NSManaged var temperature: String
    @NSManaged var timeTemp: Date
    @NSManaged var wind: String
    @NSManaged var city: CityModel
}

extension WeatherInfoModel {
    @nonobjc class func fetchRequest() -> NSFetchRequest<WeatherInfoModel> {
        NSFetchRequest<WeatherInfoModel>(entityName: "WeatherInfoModel")
    }
}
