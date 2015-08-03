//
//  ExtensionTests.swift
//  Blockly2
//
//  Created by Joey Chan on 03/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class ExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDistanceBetween1() {
        let point1 = CGPointMake(0, 0)
        let point2 = CGPointMake(3, 4)
        let actualDistance = distanceBetween(point1, point2)
        let expectedDistance = CGFloat(5)
        XCTAssertEqual(expectedDistance, actualDistance, "Expected Distance is \(expectedDistance) but actual distance is \(actualDistance)")
    }
    
    func testDistanceBetween2() {
        let point1 = CGPointMake(0, 0)
        let point2 = CGPointMake(-3, -4)
        let actualDistance = distanceBetween(point1, point2)
        let expectedDistance = CGFloat(5)
        XCTAssertEqual(expectedDistance, actualDistance, "Expected Distance is \(expectedDistance) but actual distance is \(actualDistance)")
    }
    
    func testDistanceBetween3() {
        let point1 = CGPointMake(3, 0)
        let point2 = CGPointMake(0, 4)
        let actualDistance = distanceBetween(point1, point2)
        let expectedDistance = CGFloat(5)
        XCTAssertEqual(expectedDistance, actualDistance, "Expected Distance is \(expectedDistance) but actual distance is \(actualDistance)")
    }
    
    func testCGFloatAddition1() {
        let point1 = CGPointMake(3, 0)
        let point2 = CGPointMake(4, 0)
        let actualResult = point1 + point2
        let expectedResult = CGPointMake(7, 0)
        XCTAssertEqual(expectedResult, actualResult, "Expected result is \(expectedResult) but actual result is \(actualResult)")
    }
    
    func testCGFloatAddition2() {
        let point1 = CGPointMake(6, 2)
        let point2 = CGPointMake(2, 2)
        let actualResult = point1 + point2
        let expectedResult = CGPointMake(8, 4)
        XCTAssertEqual(expectedResult, actualResult, "Expected result is \(expectedResult) but actual result is \(actualResult)")
    }
    
    func testCGFloatAddition3() {
        let point1 = CGPointMake(3, 4)
        let point2 = CGPointMake(4, 3)
        let actualResult = point1 + point2
        let expectedResult = CGPointMake(7, 7)
        XCTAssertEqual(expectedResult, actualResult, "Expected result is \(expectedResult) but actual result is \(actualResult)")
    }
    

}
