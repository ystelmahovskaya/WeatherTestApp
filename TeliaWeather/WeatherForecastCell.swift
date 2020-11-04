//
//  WeatherForecastCell.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class WeatherForecastCell: UITableViewCell {
    let identifier = "WeatherForecastCell"
    
    
    lazy var day:UILabel = {
        var name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    lazy var temperature:UILabel = {
        var temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textAlignment = .right
        return temp
    }()
    
    lazy var weatherDescription: UILabel = {
        var description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    lazy var icon: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        addSubview(day)
        addSubview(temperature)
        addSubview(weatherDescription)
        addSubview(icon)
        NSLayoutConstraint.activate([
            day.topAnchor.constraint(equalTo: topAnchor),
            day.bottomAnchor.constraint(equalTo: bottomAnchor),
            day.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            day.widthAnchor.constraint(equalToConstant: 150),
            temperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            temperature.topAnchor.constraint(equalTo: topAnchor),
            temperature.bottomAnchor.constraint(equalTo: bottomAnchor),
            temperature.widthAnchor.constraint(equalToConstant: 100),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor),
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.trailingAnchor.constraint(equalTo: temperature.leadingAnchor),
            weatherDescription.topAnchor.constraint(equalTo: topAnchor),
            weatherDescription.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherDescription.leadingAnchor.constraint(equalTo: day.trailingAnchor),
            weatherDescription.trailingAnchor.constraint(equalTo: icon.leadingAnchor)
        ])
        accessibilityIdentifier = "weather_cell"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
