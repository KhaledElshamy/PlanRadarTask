//
//  CitiesConfigurator.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit


class CitiesConfigurator {
    
    static func citiesListViewController() -> UIViewController {
        let viewControlelr = CitiesListViewController()
        let citiesViewModel:citiesViewModelDelegate = CitiesViewModel()
        viewControlelr.viewModel = citiesViewModel
        return viewControlelr
    }
}
