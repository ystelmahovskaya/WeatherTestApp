//
//  City+CoreDataProperties.swift
//  
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var weather: [WeatherUnit]?

}
