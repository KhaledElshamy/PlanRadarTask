//
//  CityDetailsView.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import UIKit



class CityDetailsView: UIView {
    
    lazy private var scrollView : UIScrollView = {
       let view = UIScrollView()
        view.addSubview(containerScrollView)
        containerScrollView.anchor(top: view.topAnchor , leading: view.leadingAnchor , bottom: view.bottomAnchor , trailing: view.trailingAnchor )
        containerScrollView.widthAnchor.constraint(equalTo: view.widthAnchor , multiplier: 1).isActive = true
        return view
    }()
    
    lazy private var  containerScrollView : UIView = {
       let view = UIView()
        return view
    }()
    
    let cancelBackgroundImage: UIView = {
        let backGroundImageView = UIView()
        backGroundImageView.isUserInteractionEnabled = true 
        backGroundImageView.backgroundColor = .systemBlue
        backGroundImageView.clipsToBounds = true
        backGroundImageView.layer.cornerRadius = 30
        backGroundImageView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        return backGroundImageView
    }()
    
    let  cancelCrossButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Cross"), for: .normal)
        return button
    }()
    
    
    let titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }()
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.layer.cornerRadius = 20
        stackView.spacing = 8
        stackView.addShadow()
        
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(humidityLabel)
        stackView.addArrangedSubview(windSpeedLabel)
        stackView.backgroundColor = .white
        return stackView
    }()
    
    lazy var weatherImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud-computing")
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.anchor(width:70,height:200)
        return imageView
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = .black
        label.anchor(height: 30)
        return label
    }()
    
    let temperatureLabel:UILabel = {
        let label = UILabel()
        label.text = "temp"
        label.textColor = .black
        label.anchor(height: 30)
        return label
    }()
    
    let humidityLabel:UILabel = {
        let label = UILabel()
        label.text = "humidity"
        label.textColor = .black
        label.anchor(height: 30)
        return label
    }()
    
    let windSpeedLabel:UILabel = {
        let label = UILabel()
        label.text = "wind speed"
        label.textColor = .black
        label.anchor(height: 30)
        return label
    }()
    
    let bottomDescription:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        
        addSubview(cancelBackgroundImage)
        cancelBackgroundImage.anchor(top: topAnchor, leading: leadingAnchor, width: 100, height: 100)
        
        addSubview(cancelCrossButton)
        cancelCrossButton.anchor(top: cancelBackgroundImage.topAnchor, leading: cancelBackgroundImage.leadingAnchor, bottom: cancelBackgroundImage.bottomAnchor, trailing: cancelBackgroundImage.trailingAnchor,
                           paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        addSubview(titleLabel)
        titleLabel.anchor(centerX:centerXAnchor, centerY: cancelBackgroundImage.centerYAnchor, width: 100)
//
        addSubview(scrollView)
        scrollView.anchor(top:cancelBackgroundImage.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)

        containerScrollView.addSubview(detailsStackView)
        detailsStackView.anchor(top:cancelBackgroundImage.bottomAnchor,leading: containerScrollView.leadingAnchor,trailing: containerScrollView.trailingAnchor, paddingTop: 64,paddingLeft: 64, paddingRight: 64)
        
        containerScrollView.addSubview(bottomDescription)
        bottomDescription.anchor(top:detailsStackView.bottomAnchor, leading: containerScrollView.leadingAnchor, bottom: containerScrollView.bottomAnchor, trailing: containerScrollView.trailingAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 8, paddingRight: 32)
        
        weatherImage.anchor(top: detailsStackView.topAnchor,centerX:detailsStackView.centerXAnchor, paddingTop: 16)
    }
}
