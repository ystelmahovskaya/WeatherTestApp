//
//  DecodeHelper.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-03.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import SwiftyJSON

class DecodeHelper {
    /**
     decode JSON for current weather request and wraps it to temporary holder
     */
    static func decodeCurrentWeather(data:Data) -> WeatherUnitWrapper? {
        if let json = try? JSON(data: data){
            
            var weatherDescs: [String] = [String]()
            for weatherdescs in json["weather"].arrayValue {
                weatherDescs.append(weatherdescs["main"].stringValue)
            }
            let weatherTime = json["dt"].int32Value
            let temp = json["main"]["temp"].doubleValue
            return WeatherUnitWrapper(temperatureWrapper: temp, descriptionWrapper: weatherDescs[0], timeWrapper: weatherTime)
        }
        return nil
    }
    
    /**
     decode JSON for 5 days forecast weather request and wraps it to temporary holder
     */
    static func decodeForecast(data:Data) -> WeatherUnitArrayWrapper? {
        
        var weatherUnits = [WeatherUnitWrapper]()
        if let json = try? JSON(data: data) {
            for weatheritem in json["list"].arrayValue {
                let temp = weatheritem["main"]["temp"].doubleValue
                var weatherDescs: [String] = [String]()
                for weatherdescs in weatheritem["weather"].arrayValue {
                    weatherDescs.append(weatherdescs["main"].stringValue)
                }
                let weatherTime = weatheritem["dt"].int32Value
                let weatherTimeDouble = weatheritem["dt"].doubleValue
                let dateString = weatheritem["dt_txt"].stringValue
                let date = NSDate(timeIntervalSince1970: weatherTimeDouble)
                
                let weatherUnit = WeatherUnitWrapper(temperatureWrapper: temp, descriptionWrapper: weatherDescs[0], timeWrapper: weatherTime)
                weatherUnits.append(weatherUnit)
            }
            let weatherUnitArrayWrapper = WeatherUnitArrayWrapper(array: weatherUnits)
            return weatherUnitArrayWrapper
        }
        return nil
    }
}
