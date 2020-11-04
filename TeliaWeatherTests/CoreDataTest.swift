//
//  CoreDataTest.swift
//  TeliaWeatherTests
//
//  Created by Yuliia Stelmakhovska on 2020-11-03.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import XCTest
import UIKit

@testable import TeliaWeather

class CoreDataTest: XCTestCase {
    
    var manager:CoreDataManager? = nil
    
    override func setUp() {
        manager = CoreDataManager()
    }
    
    func testCreateWeatherUnit(){
        let unit = manager!.createWeatherUnit(time: 1604258400, temperature: 10.2, description: "Clouds")
        XCTAssertNotNil(unit)
        XCTAssertEqual(unit?.temperature, 10.2)
        XCTAssertEqual(unit?.time, 1604258400)
        XCTAssertTrue(unit!.isKind(of: WeatherUnit.self))
    }
    
    func testCreateCity(){
        let unit1 =  WeatherUnitWrapper(temperatureWrapper: 1, descriptionWrapper: "Sunny", timeWrapper: 1604258400)
        let unit2 =  WeatherUnitWrapper(temperatureWrapper: 2, descriptionWrapper: "Rain", timeWrapper: 1604258400)
        let unit3 =  WeatherUnitWrapper(temperatureWrapper: 3, descriptionWrapper: "Sunny", timeWrapper: 1604258400)
        let unit4 =  WeatherUnitWrapper(temperatureWrapper: 4, descriptionWrapper: "Clouds", timeWrapper: 1604258400)
        let unit5 =  WeatherUnitWrapper(temperatureWrapper: 5, descriptionWrapper: "Sunny", timeWrapper: 1604258400)
        
        let current = WeatherUnitWrapper(temperatureWrapper: 10, descriptionWrapper: "Sunny", timeWrapper: 1604258400)
        let result = manager?.createCityAndSaveToDB(name: "TEST", currentWeather: current, forecastUnits: [unit1,unit2,unit3,unit4,unit5])
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.currentWeather?.temperature, 10)
        XCTAssertEqual(result?.weather?.count, 5)
        XCTAssertTrue(result!.isKind(of: City.self))
        
        manager?.getCityFromDataBase(name: "TEST", completion: { city in
            XCTAssertNotNil(city)
            XCTAssertEqual(result?.currentWeather?.temperature, city?.currentWeather?.temperature)
            XCTAssertEqual(result?.name, city?.name)
            XCTAssertEqual(result?.weather?.count, city?.weather?.count)
        })
    }
    
    func testGetCity(){
        manager?.getCityFromDataBase(name: "TEST!", completion: { city in
            XCTAssertNil(city)
        })
    }
}
