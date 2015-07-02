//
//  FetchLevelsActionTest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SwiftyJSON
import XCTest

class FetchLevelsActionTest: XCTestCase {

    var storyboard : UIStoryboard?
    
    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        
    }
    
    func testDevDelegate() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("LevelTableViewController") as! LevelTableViewController
        
        for episode in 1 ... 100 {
            let expectation = expectationWithDescription("Dev API Episode 1")
            FetchLevelsAction(controller, "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/episodes/\(episode)").switchToDev().execute {
                expectation.fulfill()
            }
            waitForExpectationsWithTimeout(10) { (error) -> Void in
                if error != nil {
                    println(error)
                }
            }
            XCTAssertGreaterThan(controller.levels.count, 0, "Level count == 0")
        }

    }

    func testMockDelegate() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("LevelTableViewController") as! LevelTableViewController
        let delegate = FetchLevelsActionMockDelegate()
        FetchLevelsAction(controller, "").switchToMock().execute {}
        XCTAssertEqual(controller.levels.count, 4, "Level count does not match")
    }

}
