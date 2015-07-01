//
//  GameViewControllerTests.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class GameViewControllerTests: XCTestCase {
    
    let expectedButtonCount = 3
//    let testLevel = Level(number: 1, description: "Testing")
    let timeout: NSTimeInterval = 30
    
    
    var frame = CGRect()
    var controller: GameViewController?

    override func setUp() {
        super.setUp()
        controller = GameViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test1ControllerNotNil() {
        XCTAssertNotNil(controller, "GameViewController is nil")
    }
    
//    func test2WebView() {
//        XCTAssertNil(controller!.webView, "WebView is not nil before initialization")
//        controller!.setupWebView()
//        XCTAssertNotNil(controller!.webView, "WebView is nil after initialization")
//    }
    
//    func test4SetUpDirectDrive() {
//        XCTAssertNil(controller!.directDriveViewController, "DirectDriveController is not nil before initialization")
//        controller!.setupDirectDrive()
//        XCTAssertNotNil(controller!.directDriveViewController, "CargoController is nil after initialization")
//    }
    
//    // TODO
//    func test5SetUpButtonSet() {
//        XCTAssertEqual(controller!.buttonSet.count, 0, "ButtonSet is not empty before Initialization")
////        controller!.setupButtonSet()
//        
//        let expected = expectedButtonCount
//        let actual = controller!.buttonSet.count
////        XCTAssertEqual(expected, actual, "ButtonSet has an expected count of \(expected), but actual is \(actual)")
//    }
    
//    func test6LoadLevel() {
//        let expectation = expectationWithDescription("LoadLevel")
//        controller!.setupWebView(frame)
//        GameViewCommandFactory.LoadLevelCommand(testLevel, gameViewController: controller!).execute {
//            expectation.fulfill()
//        }
//        waitForExpectationsWithTimeout(timeout) { (error) in
//            println("LoadLevelCommand cannot be performed properly")
//        }
//    }

}
