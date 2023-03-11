//
//  WeatherHistoryView.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import UIKit


class WeatherHistoryView:UIView {
    
    
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstarints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstarints(){
        addSubview(tableView)
        tableView.anchor(top:safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor,
                         paddingLeft: 8, paddingRight: 8)
    }
}

