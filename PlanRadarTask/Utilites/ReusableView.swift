//
//  ReusableView.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit

protocol ReusableView {
    static var defaultReuseIdentifier : String { get }
}

extension ReusableView where Self: UITableViewCell {
    static var defaultReuseIdentifier : String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
