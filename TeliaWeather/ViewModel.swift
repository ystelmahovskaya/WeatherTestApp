//
//  ViewModel.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ViewModel: NSObject {
    
    private var dataProvider:DataProvider = DataProvider()
    private var cityName:String?
    private(set) var city:City?{
        didSet{
            self.bindCityController()
        }
    }
    /**
     data binding for MVVM
     */
    var bindCityController : (() -> ()) = {}
    init(cityName:String) {
        
        super.init()
        self.cityName = cityName
        dataProvider.getCity(cityName: cityName, completion: { (city) in
            self.city = city
        })
    }
    
    func refreshDataForCity() {
        if let cityName = cityName {
            dataProvider.getCity(cityName: cityName, completion: { (city) in
                self.city = city
            })
        }
    }
}
