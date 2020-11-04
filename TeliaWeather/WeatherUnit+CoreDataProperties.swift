//
//  WeatherUnit+CoreDataProperties.swift
//  
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//
//

import Foundation
import CoreData


extension WeatherUnit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherUnit> {
        return NSFetchRequest<WeatherUnit>(entityName: "WeatherUnit")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var weatherDescription: String?
    @NSManaged public var time: Int32

}
