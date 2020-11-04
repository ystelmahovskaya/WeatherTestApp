//
//  DataProvider.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-02.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import CoreData

class DataProvider {
    private var coreDataManager: CoreDataManager = CoreDataManager()
    private var weatherApiClient: WeatherApiClient = WeatherApiClient(apiKey: AppConstants.APIKey)
    
    
    var retryCount = 3
    /**
     Request city item from API with 3 times retry. If responce is not successful retrives data from DB
     */
    func getCity(cityName:String, completion: @escaping ((City?) -> Void)){
        if retryCount > 0 {
            retryCount -= 1
            getCityFromApi(cityName: cityName, completion: completion)
        } else {
            getCityFromDataBase(cityName: cityName) { (city) in
                completion(city)
            }
        }
    }
    /**
     Request city item  from API
     */
    func getCityFromApi(cityName:String, completion: @escaping ((City?) -> Void)){
        weatherApiClient.fetchCurrentWeatherForCity(cityName: cityName
            , completion: { (result) in
                switch result{
                case .success(let currentWeather):
                    self.weatherApiClient.getForecast(cityName: cityName) { (resultInner) in
                        DispatchQueue.main.async {
                            switch resultInner {
                            case .success(let forecastUnits):
                                let city = CoreDataManager().createCityAndSaveToDB(name:cityName,currentWeather:currentWeather, forecastUnits: forecastUnits.array)
                                completion(city)
                            case .failure(_):
                                self.getCity(cityName: cityName, completion: completion)
                            }
                        }
                    }
                case .failure(_):
                    self.getCity(cityName: cityName, completion: completion)
                }
                
        })
    }
    
    /**
     Request city entity  from DB
     */
    private func getCityFromDataBase(cityName:String, completion: @escaping ((City?) -> Void)){
        self.coreDataManager.getCityFromDataBase(name:cityName) { (city) in
            completion(city)
        }
    }
}
