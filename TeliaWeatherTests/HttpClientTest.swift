//
//  HttpClientTest.swift
//  HttpClientTest
//
//  Created by Yuliia Stelmakhovska on 2020-11-03.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import XCTest
@testable import TeliaWeather

class HttpClientTest: XCTestCase {
    
    var apiClient:WeatherApiClient? = WeatherApiClient(apiKey: AppConstants.APIKey)
    let session = URLSessionMock()
    override func setUp() {
        let error = NSError(domain: TWNetworkingErrorDomain, code: 200, userInfo: nil)
        session.error = error
        apiClient?.session = self.session
        
    }
    
    func testfetchCurrentWeatherForCity(){
        
        apiClient?.fetchCurrentWeatherForCity(cityName: "test", completion: { result in
            XCTAssertEqual(self.session.lastURL?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?q=test&units=metric&appid=d2cc7d350effb1c5e4e5f5e7cf5e0960")
            XCTAssertNil(self.session.data)
            XCTAssertNotNil(self.session.error)
            switch result{
            case .success(_):
                  XCTAssertNil(self.session.error)
            case .failure(let err):
                XCTAssertNotNil(err)
                XCTAssertNil(self.session.data)
            }
        })
    }
    
    func testGetForecasty(){
        apiClient?.getForecast(cityName: "test1", completion: { result in
        XCTAssertEqual(self.session.lastURL?.absoluteString, "https://api.openweathermap.org/data/2.5/forecast?q=test1&units=metric&appid=d2cc7d350effb1c5e4e5f5e7cf5e0960")
            XCTAssertNil(self.session.data)
            XCTAssertNotNil(self.session.error)
        })
    }
    
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    var lastURL: URL?
    
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        self.lastURL = request.url
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}

