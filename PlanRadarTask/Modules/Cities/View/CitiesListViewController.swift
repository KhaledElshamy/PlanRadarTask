//
//  CitiesListViewController.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit


class CitiesListViewController:BaseVC<CitiesView> {
    
    var viewModel:citiesViewModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitleAndColor()
        addNavigationBarButtonItem()
    }
    
    private func setNavigationBarTitleAndColor(){
        navigationController?.navigationBar.topItem?.title = "Cities"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func addNavigationBarButtonItem(){
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(showAddCityAlertController))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc private func showAddCityAlertController(){
        let alertController = UIAlertController(title: "Add City", message: "Please add your favorite city", preferredStyle: .alert)
        alertController.addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = "Enter City Name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
