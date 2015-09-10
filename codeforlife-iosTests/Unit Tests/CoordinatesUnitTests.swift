//
//  CoordinatesUnitTests.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class CoordinatesUnitTests: XCTestCase {
    
    let numberOfIterations = 10000000

    func testAddition1() {
        let c1 = Coordinates(1, 2)
        let c2 = Coordinates(3, 4)
        let actualResult = c1 + c2
        let expectedResult = Coordinates(4, 6)
        XCTAssertTrue(expectedResult == actualResult, "\(c1.toString) + \(c2.toString) shoulb be \(expectedResult) instead of \(actualResult)")
    }
    
    func testAddition2() {
        let c1 = Coordinates(-5, -8)
        let c2 = Coordinates(4, 17)
        let actualResult = c1 + c2
        let expectedResult = Coordinates(-1, 9)
        XCTAssertTrue(expectedResult == actualResult, "\(c1.toString) + \(c2.toString) shoulb be \(expectedResult) instead of \(actualResult)")
    }
    
    func testSubtraction1() {
        let c1 = Coordinates(1, 2)
        let c2 = Coordinates(3, 4)
        let actualResult = c1 - c2
        let expectedResult = Coordinates(-2, -2)
        XCTAssertTrue(expectedResult == actualResult, "\(c1.toString) + \(c2.toString) shoulb be \(expectedResult) instead of \(actualResult)")
    }

    func testSubtraction2() {
        let c1 = Coordinates(-5, -8)
        let c2 = Coordinates(4, 17)
        let actualResult = c1 - c2
        let expectedResult = Coordinates(-9, -25)
        XCTAssertTrue(expectedResult == actualResult, "\(c1.toString) + \(c2.toString) shoulb be \(expectedResult) instead of \(actualResult)")
    }
    
    func testAdditionEfficiency() {
        self.measureBlock({
            [unowned self] in
            var c1 = Coordinates(0, 0)
            var c2 = Coordinates(1, 1)
            for i in 1 ... self.numberOfIterations {
                c1 += c2
            }
        })
    }
    
    func testAdditionEfficiencyWithoutUsingCoordinates() {
        self.measureBlock({
            [unowned self] in
            var c1 = Coordinates(0, 0)
            var c2 = Coordinates(1, 1)
            for i in 1 ... self.numberOfIterations {
                c1.x += c2.x
                c1.y += c2.y
            }
        })
    }
    
}
