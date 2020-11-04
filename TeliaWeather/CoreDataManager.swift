//
//  CoreDataManager.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    /**
     Get city entity from databace
     */
    func getCityFromDataBase(name:String, completion: ((City?) -> Void)){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                completion(nil)
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let city = try managedContext.fetch(fetchRequest).last as? City
            completion(city)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(nil)
        }
    }
    
    /**
     Save city entity to  databace,
     TODO: Clean caches
     */
    func createCityAndSaveToDB(name:String, currentWeather:WeatherUnitWrapper, forecastUnits:[WeatherUnitWrapper]?) -> City?{
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        
        let city = NSEntityDescription.insertNewObject(forEntityName: "City", into: context) as! City
        city.addToWeather(NSSet(set: convertWeatherUnitWrapperToSet(units: forecastUnits)))
        city.setValue(createWeatherUnit(time: currentWeather.timeWrapper, temperature: currentWeather.temperatureWrapper, description: currentWeather.descriptionWrapper), forKey: "currentWeather")
        city.setValue(name, forKey: "name")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return city
    }
    /**
      Helper for creating  DB entities
      */
    func createWeatherUnit(time:Int32, temperature: Double, description:String) -> WeatherUnit?{
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        let weatherUnit = NSEntityDescription.insertNewObject(forEntityName: "WeatherUnit", into: context) as! WeatherUnit
        
        weatherUnit.time = time
        weatherUnit.temperature = temperature
        weatherUnit.weatherDescription = description
        try? context.save()
        return weatherUnit
        
    }
    /**
    Helper for converting network layer wrappers to DB entities
    */
    private func convertWeatherUnitWrapperToSet(units:[WeatherUnitWrapper]?)-> Set<NSManagedObject>{
        var weatherUnits: Set = Set<NSManagedObject>()
        if let units = units {
            for unit in units {
                if let convertedUnit = createWeatherUnit(time: unit.timeWrapper, temperature: unit.temperatureWrapper, description: unit.descriptionWrapper) {
                    weatherUnits.insert(convertedUnit)
                }
            }
        }
        return weatherUnits
    }
    
}
