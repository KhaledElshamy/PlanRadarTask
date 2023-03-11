//
//  NibLoadable.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit

protocol NibLoadable {
    static var nibName : String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName : String {
        return String(describing: self)
    }
}

extension UITableViewCell:NibLoadable{}
