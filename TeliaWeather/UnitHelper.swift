//
//  UnitHelper.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation

class UnitHelper {
    /**
     Convert double value to String with adding "°"
     */
    func convertDoubleToStringDegrees(doubleValue:Double) -> String {
        return  String(format: "%.0f", doubleValue) + "°"
    }
    
    
    /**
     Convert Int32 value to String Date with format "dd MMM HH:mm"
     */
    func convertInt32ToStringDate(int32:Int32) -> String {
        let date = NSDate(timeIntervalSince1970: Double(int32))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        return  dateString
    }
}
