//
//  WeatherIconManager.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-02.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation

import UIKit
/**
 returns Icons for some of weather descriptions
 */
enum WeatherIconManager: String{
    
    case clearSky = "01d"
    case fewClouds = "02d"
    case scatteredClouds = "03d"
    case brokenClouds = "04d"
    case showerRain = "09d"
    case rain = "10d"
    case thunderstorm = "11d"
    case snow = "13d"
    case mist = "50d"
    case UnpredictedIcon = "04n"
    
    init(rawValue: String){
        switch rawValue {
        case "Clear": self = .clearSky
        case "Clouds": self = .fewClouds
        case "scattered clouds": self = .scatteredClouds
        case "broken clouds": self = .brokenClouds
        case "shower rain": self = .showerRain
        case "Rain": self = .rain
        case "Thunderstorm": self = .thunderstorm
        case "Snow": self = .snow
        case "Mist": self = .mist
        default : self = .UnpredictedIcon
            
        }
    }
}

extension WeatherIconManager{
    var image:UIImage{
        return UIImage(named: self.rawValue)!
    }
}
