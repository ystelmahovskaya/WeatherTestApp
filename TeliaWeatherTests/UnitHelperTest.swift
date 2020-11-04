//
//  UnitHelperTest.swift
//  TeliaWeatherTests
//
//  Created by Yuliia Stelmakhovska on 2020-11-03.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import XCTest
@testable import TeliaWeather

class UnitHelperTest: XCTestCase {
    
    
    func testConvertDoubleToStringDegrees()  {
        var testcase = 12.9
        var result = UnitHelper().convertDoubleToStringDegrees(doubleValue: testcase)
        XCTAssertEqual(result, "13°")
        testcase = -11.9
        result = UnitHelper().convertDoubleToStringDegrees(doubleValue: testcase)
        XCTAssertEqual(result, "-12°")
        testcase = 0
        result = UnitHelper().convertDoubleToStringDegrees(doubleValue: testcase)
        XCTAssertNotEqual(result, "test")
    }
    
    func testConvertInt32ToStringDate(){
        let testcase:Int32 = 1604258400
        let result = UnitHelper().convertInt32ToStringDate(int32: testcase)
        XCTAssertEqual(result, "01 Nov 20:20")
        XCTAssertNotEqual(result, "test")
    }
    
}
