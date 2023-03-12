//
//  CitiesConfigurator.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit


class CitiesConfigurator {
    
    static func citiesListViewController(dataController:DataController) -> UIViewController {
        let viewControlelr = CitiesListViewController()
        let cityWeatherFetcher:CityWeatherFetcherDelegate = CityWeatherFetcher()
        let cityWeatherLocalStorage:CityWeatherLocalStorrageDelegate = CityWeatherLocalStorage(dataController: dataController,
                                                                                               managedObjectContext: dataController.mainContext)
        let citiesViewModel:CitiesViewModelDelegate = CitiesViewModel(cityWeatherLocalStorage: cityWeatherLocalStorage,
                                                                      cityWeatherFetcher: cityWeatherFetcher)
        viewControlelr.viewModel = citiesViewModel
        return viewControlelr
    }
}
