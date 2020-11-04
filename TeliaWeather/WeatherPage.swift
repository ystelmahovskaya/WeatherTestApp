//
//  WeatherPage.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import UIKit
/**
 Page for showing weather for each city
 */
class WeatherPage : UIViewController, UITableViewDelegate {
    
    var cityName: String
    var viewModel: ViewModel?
    let dataSource = ForecastTableViewDataSource()
    
    init(cityName: String) {
        self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cityNameLabel:UILabel = {
        var name = UILabel()
        name.font = name.font.withSize(20)
        name.text = cityName
        name.accessibilityIdentifier = "city_label"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var currentTemperature:UILabel = {
        var temp = UILabel()
        temp.font = temp.font.withSize(30)
        temp.accessibilityIdentifier = "current_temp"
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var weatherDescription: UILabel = {
        var description = UILabel()
        description.font = description.font.withSize(18)
        description.textAlignment = .center
        description.accessibilityIdentifier = "weather_desc"
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var tableView: UITableView = {
        var tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self.dataSource
        tv.tableFooterView = UIView()
        tv.rowHeight = 50
        tv.accessibilityIdentifier = "table_view"
        tv.register(WeatherForecastCell.self, forCellReuseIdentifier: "WeatherForecastCell")
        return tv
    }()
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.accessibilityIdentifier = "image_view"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addViews()
        viewModel = ViewModel(cityName: cityName)
        viewModel?.bindCityController = {
            self.updateData()
        }
    }
    
    private lazy var refreshControl :UIRefreshControl = {
        var refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    
    private func addViews(){
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        view.addSubview(weatherDescription)
        view.addSubview(currentTemperature)
        view.addSubview(cityNameLabel)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 350),
            weatherDescription.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            weatherDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: weatherDescription.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currentTemperature.bottomAnchor.constraint(equalTo: imageView.topAnchor),
            currentTemperature.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentTemperature.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityNameLabel.bottomAnchor.constraint(equalTo: currentTemperature.topAnchor),
            cityNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            cityNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        
    }
    
    /**
     Updetes UI when View Model updates
     */
    func updateData(){
        
        if let temp = self.viewModel?.city?.currentWeather?.temperature{
            self.currentTemperature.text = UnitHelper().convertDoubleToStringDegrees(doubleValue: temp )
        }
        if let description = self.viewModel?.city?.currentWeather?.weatherDescription{
            self.weatherDescription.text = description
            let icon = WeatherIconManager(rawValue: description).image
            imageView.image = icon
        }
        
        if let units = self.viewModel?.city?.weather?.allObjects as? [WeatherUnit]{
            self.dataSource.update(weatherUnits: units)
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    /**
     Simple data refresh function implemented only for pulling on table view
     */
    @objc func refresh(_ sender: AnyObject) {
        viewModel?.refreshDataForCity()
    }
    
}
