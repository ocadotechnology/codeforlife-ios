//
//  LabelViewControllerTest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class LabelViewControllerTest: XCTestCase {
    
    var controller: LevelTableViewController?

    override func setUp() {
        super.setUp()
        controller = LevelTableViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testControllerNotNil() {
        // This is an example of a functional test case.
        XCTAssertNotNil(controller, "LevelTableViewController is nil")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
