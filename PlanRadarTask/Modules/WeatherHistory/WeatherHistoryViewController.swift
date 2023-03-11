//
//  WeatherHistoryViewController.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import UIKit



class WeatherHistoryViewController:BaseVC<WeatherHistoryView> {
    
    private var weathers: [City] = []
    
    init(weathers: [City]) {
        self.weathers = weathers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView(){
        mainView.tableView.register(WeatherHistoryTableViewCell.self)
        mainView.tableView.dataSource = self
    }
}

extension WeatherHistoryViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WeatherHistoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.dateLabel.text = weathers[indexPath.row].dateString
        cell.weatherStatusLabel.text = weathers[indexPath.item].description
        return cell
    }
}
