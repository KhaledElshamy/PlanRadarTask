//
//  CityModel.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import CoreData

@objc(CityModel)
final class CityModel: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var weatherSet: NSSet?
    public override var description: String {
            return name
        }
    var weathers: [WeatherInfoModel] {
        weatherSet!.map({ $0 as! WeatherInfoModel })
    }
}

extension CityModel {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CityModel> {
        NSFetchRequest<CityModel>(entityName: "CityModel")
    }
}
