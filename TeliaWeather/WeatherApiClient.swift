//
//  WeatherApiClient.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

/**
 Endpoints for different types of request
 */
enum ForecastType: FinalURLPoint{
    case Forecast5Days(apiKey:String, cityName: String)
    case CurrentWeather(apiKey:String, cityName: String)
    var baseURL: URL{
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    var path: String{
        switch self {
        case .Forecast5Days(let apiKey, let cityName):
            return "forecast?q=\(cityName)&units=metric&appid=\(apiKey)"
        case .CurrentWeather(apiKey: let apiKey, cityName: let cityName):
            return "weather?q=\(cityName)&units=metric&appid=\(apiKey)"
        }
        
    }
    var request: URLRequest{
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
        
    }
    
}

struct WeatherUnitWrapper{
    var temperatureWrapper:Double
    var descriptionWrapper:String
    var timeWrapper:Int32
}

struct WeatherUnitArrayWrapper{
    var array:[WeatherUnitWrapper]
    
}

class WeatherApiClient: APIClient {
    
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    let apiKey: String
    
    init (sessionConfiguration: URLSessionConfiguration, apiKey:String){
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
        
    }
    convenience init(apiKey:String){
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    /**
    Makes request and returns wrapped forecast for current weather for city
    */
    func fetchCurrentWeatherForCity(cityName:String, completion: @escaping (Result<WeatherUnitWrapper, Error>) -> Void){
        let request = ForecastType.CurrentWeather(apiKey: self.apiKey, cityName: cityName).request
        fetch(request: request, parse: { (data) -> WeatherUnitWrapper? in
            return DecodeHelper.decodeCurrentWeather(data: data)
        },
              completionHandler: completion)
    }
    
    /**
       Makes request and returns wrapped forecast for 5 days for city
       */
    func getForecast(cityName:String, completion:@escaping (Result<WeatherUnitArrayWrapper, Error>) -> ()){
        
        let request = ForecastType.Forecast5Days(apiKey: self.apiKey, cityName: cityName).request
        fetch(request: request, parse: { (data) -> WeatherUnitArrayWrapper? in
            return DecodeHelper.decodeForecast(data: data)
        },
              completionHandler: completion)
        
    }
    
}
