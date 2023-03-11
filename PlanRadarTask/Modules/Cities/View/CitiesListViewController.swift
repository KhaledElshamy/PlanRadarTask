//
//  CitiesListViewController.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit
import Combine

class CitiesListViewController:BaseVC<CitiesView> {
    
    var viewModel:CitiesViewModelDelegate?
    
    private var cities: [String] = []
    private var disposables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarTitleAndColor()
        addNavigationBarButtonItem()
        setupTableView()
        subscribeOnCitiesEvent()
    }
    
    private func setupTableView(){
        mainView.tableView.register(CitiesTableViewCell.self)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    private func subscribeOnCitiesEvent(){
        if let viewModel = self.viewModel as? CitiesViewModel {
            viewModel.$dataSource
                .sink(receiveValue: { [weak self] cities in
                    self?.hideLoading()
                    self?.cities = cities
                    self?.mainView.tableView.reloadData()
                }).store(in: &self.disposables)
        }
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
            action: #selector(showAddCityAlert))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    
    @objc private func showAddCityAlert(){
        
        let alertController = UIAlertController(title: "Add City", message: "Please add your favorite city", preferredStyle: .alert)
        alertController.addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = "Enter City Name"
            textField.textPublisher
                .sink(receiveValue: { text in
                    self.viewModel?.setCityName(to: text)
                }).store(in: &self.disposables)
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if alertController.textFields![0].text != "" {
                self?.showLoading()
                self?.viewModel?.fetchCityWeatherDetails()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}



extension CitiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CitiesTableViewCell = tableView.dequeueReusableCell(for: indexPath) 
        cell.selectionStyle = .none
        cell.cityName.text = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel?.deleteCity(at: indexPath.row)
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherInfo = viewModel?.getWeatherInfo(at: indexPath.item)
        guard let info = weatherInfo else {return}
        let vc = CityDetailsViewController(model: info)
        self.present(vc, animated: true)
    }
}
