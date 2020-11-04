//
//  TeliaWeatherUITests.swift
//  TeliaWeatherUITests
//
//  Created by Yuliia Stelmakhovska on 2020-11-03.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import XCTest

class TeliaWeatherUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        app.launch()
        app.launchEnvironment = ["animations": "0"]
    }
    
    func testSwipePages() throws {
        app.staticTexts["Gothenburg"].swipeLeft()
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "city_label").firstMatch.label, "Malmo")
        app.staticTexts["Malmo"].swipeLeft()
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "city_label").firstMatch.label, "Stockholm")
        app.staticTexts["Stockholm"].swipeLeft()
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "city_label").firstMatch.label, "Gothenburg")
    }
    
    func testMainImagesAndVisible() throws {
        XCTAssertNotNil(app.images.element(matching: .image, identifier: "image_view").firstMatch)
        XCTAssertEqual(app.images.element(matching: .image, identifier: "image_view").firstMatch.frame.size.height, 100)
        XCTAssertEqual(app.images.element(matching: .image, identifier: "image_view").firstMatch.frame.size.width, 100)
        XCTAssertNotNil(app.staticTexts.element(matching: .any, identifier: "current_temp").firstMatch)
        XCTAssertNotNil(app.staticTexts.element(matching: .any, identifier: "weather_desc").firstMatch)
        XCTAssertNotNil(app.tables.element(matching: .table, identifier: "table_view").firstMatch)
        app.staticTexts["Gothenburg"].swipeLeft()
        XCTAssertNotNil(app.images.element(matching: .image, identifier: "image_view").firstMatch)
        XCTAssertEqual(app.images.element(matching: .image, identifier: "image_view").firstMatch.frame.size.height, 100)
        XCTAssertEqual(app.images.element(matching: .image, identifier: "image_view").firstMatch.frame.size.width, 100)
        XCTAssertNotNil(app.staticTexts.element(matching: .any, identifier: "current_temp").firstMatch)
        XCTAssertNotNil(app.staticTexts.element(matching: .any, identifier: "weather_desc").firstMatch)
        XCTAssertNotNil(app.tables.element(matching: .table, identifier: "table_view").firstMatch)
        app.staticTexts["Malmo"].swipeLeft()
        XCTAssertNotNil(app.images.element(matching: .image, identifier: "image_view").firstMatch)
        XCTAssertEqual(app.images.element(matching: .image, identifier: "image_view").firstMatch.frame.size.height, 100)
        XCTAssertEqual(app.images.element(matching: .image, identifier: "image_view").firstMatch.frame.size.width, 100)
        XCTAssertNotNil(app.staticTexts.element(matching: .any, identifier: "current_temp").firstMatch)
        XCTAssertNotNil(app.staticTexts.element(matching: .any, identifier: "weather_desc").firstMatch)
        XCTAssertNotNil(app.tables.element(matching: .table, identifier: "table_view").firstMatch)
    }
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
