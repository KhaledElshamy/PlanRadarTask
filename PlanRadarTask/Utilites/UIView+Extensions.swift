//
//  UIView+Extensions.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit
import Combine
import PINRemoteImage

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil , leading: NSLayoutXAxisAnchor? = nil , bottom: NSLayoutYAxisAnchor? = nil , trailing: NSLayoutXAxisAnchor? = nil , centerX:NSLayoutXAxisAnchor? = nil ,centerY: NSLayoutYAxisAnchor? = nil ,paddingTop: CGFloat = 0 ,paddingLeft: CGFloat = 0 ,paddingBottom: CGFloat = 0 ,paddingRight: CGFloat = 0 , width: CGFloat = 0 ,height: CGFloat = 0 ,paddingCenterX: CGFloat = 0 ,paddingCenterY: CGFloat = 0) {
           translatesAutoresizingMaskIntoConstraints = false
           
           if let top = top {
               topAnchor.constraint(equalTo: top, constant:paddingTop).isActive = true
           }
           
           if let left = leading {
               leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
           }
           
           if let bottom = bottom {
               bottomAnchor.constraint(equalTo: bottom, constant:-paddingBottom).isActive = true
           }
           
           if let right = trailing {
               trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
           }
           
           if width != 0 {
               widthAnchor.constraint(equalToConstant: width).isActive = true
           }
           
           if height != 0 {
               heightAnchor.constraint(equalToConstant: height).isActive = true
           }
           if let centerX = centerX {
               centerXAnchor.constraint(equalTo: centerX, constant: paddingCenterX).isActive = true
           }
           if let centerY = centerY {
               centerYAnchor.constraint(equalTo: centerY, constant: paddingCenterY).isActive = true
           }
       }
}

extension UIView {
    func addShadow(){
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}

extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }

}


extension UITableView {
    
    func register<Cell: UITableViewCell>(_: Cell.Type) {
        let bundle = Bundle(for: Cell.self)
        let nib = UINib(nibName: Cell.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: Cell.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.defaultReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.defaultReuseIdentifier)")
        }
        return cell
    }
}


extension UIImageView {
    func loadImage (url : String , placeHolder : UIImage = #imageLiteral(resourceName: "place-holder-gallary-error") ) {
        
    self.pin_updateWithProgress = true
        self.pin_setImage(from: URL(string: url ) , placeholderImage: placeHolder )
    }
    
    func loadProfileImage (url : String , placeHolder : UIImage = #imageLiteral(resourceName: "MicrosoftTeams-image") ) {
    self.pin_updateWithProgress = true
        self.pin_setImage(from: URL(string: url ) , placeholderImage: placeHolder )
    }
}
