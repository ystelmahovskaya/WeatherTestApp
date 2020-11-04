//
//  ForecastTableViewDataSource.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import UIKit

class ForecastTableViewDataSource: NSObject, UITableViewDataSource {
    var weatherUnits:[WeatherUnit]?
    
    func update(weatherUnits:[WeatherUnit]?) {
        self.weatherUnits = weatherUnits?.sorted(by: { $0.time < $1.time })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherUnits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherForecastCell") as! WeatherForecastCell
        if let time = weatherUnits?[indexPath.row].time {
            cell.day.text = UnitHelper().convertInt32ToStringDate(int32: time)
        }
        
        if let temperature = weatherUnits?[indexPath.row].temperature {
            cell.temperature.text = UnitHelper().convertDoubleToStringDegrees(doubleValue: temperature)
        }
        if let weatherDescription = weatherUnits?[indexPath.row].weatherDescription {
            cell.weatherDescription.text = weatherDescription
            let icon = WeatherIconManager(rawValue: weatherDescription).image
            cell.icon.image = icon
        }
        
        
        return cell
    }
}
