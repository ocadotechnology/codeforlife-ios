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
    
    var timeout = 10
    
    let expectedMockSectionCount = 2
    let expectedMockLevelInSectionZeroCount = 4

    override func setUp() {
        super.setUp()
        controller = LevelTableViewController()
        
        let expectation = expectationWithDescription("FetchLevelsAction")
        FetchLevelsAction(viewController: controller!).execute {
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10) {(error) in
            println("FetchLevelAction cannot be performed properly")
        }

    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testControllerNotNil() {
        // This is an example of a functional test case.
        XCTAssertNotNil(controller, "LevelTableViewController is nil")
    }
    
    func testSectionCount() {
        
        let expected = expectedMockSectionCount
        let actual = controller!.numberOfSectionsInTableView(UITableView())
        XCTAssertEqual(expected, actual, "Expected section number is \(expected), but actual is \(actual)")
        
    }
    
    func testAutoReloadDataAfterNewSection() {
        controller!.levels.addSection("Testing")
        let expected = expectedMockSectionCount + 1
        let actual = controller!.numberOfSectionsInTableView(UITableView())
        XCTAssertEqual(expected, actual, "Expected section number is \(expected), but actual is \(actual)")
    }
    
    func testLevelCount() {
        let expected = expectedMockLevelInSectionZeroCount
        let actual = controller!.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(expected, actual, "Expected Level count is \(expected), but actual is \(actual)")
        
    }
    
    func testAutoReloadDataAfterAddingNewLevel() {
        controller!.levels.getSection(0)?.addLevel(Level(number: 5, description: "Testing"))
        let expected = expectedMockLevelInSectionZeroCount + 1
        let actual = controller!.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(expected, actual, "Expected Level count is \(expected), but actual is \(actual)")
        
    }
    
    func testSectionTitle() {
        for sectionNumber in (0..<expectedMockSectionCount) {
            let expected = "Section \(sectionNumber + 1) : \(controller!.levels.getSection(sectionNumber)!.name!)"
            let actual = controller!.tableView(UITableView(), titleForHeaderInSection: sectionNumber)!
            XCTAssertEqual(expected, actual, "Expected Level count is \(expected), but actual is \(actual)")
        }
    }
    
//    func testLevelView() {
//        
//        for sectionNumber in (0..<expectedMockSectionCount) {
//            if let section = controller!.levels.getSection(sectionNumber) {
//                let levelCount = section.count
//                for levelNumber in (0..<levelCount) {
//                    if let level = controller!.levels.getSection(sectionNumber)?.getLevel(levelNumber) {
//                        let indexPath = NSIndexPath(forRow: levelNumber, inSection: sectionNumber)
//                        if let cell = UITableView().dequeueReusableCellWithIdentifier(controller!.CellReuseIdentifier, forIndexPath: indexPath) as? LevelTableViewCell {
//                            let expectedNumber = "Level \(level.number!)"
//                            let expectedDescription = level.description!
//                            
//                            let actualNumber = cell.numberLabel.text!
//                            let actualDescription = cell.descriptionLabel.text!
//                            
//                            XCTAssertEqual(expectedNumber, actualNumber, "Expected Level Number is \(expectedNumber), but actual is \(actualNumber)")
//                            
//                            XCTAssertEqual(expectedDescription, actualDescription, "Expected Level Number is \(expectedDescription), but actual is \(actualDescription)")
//                        } else {
//                            XCTAssertTrue(false, "Cannot get cell")
//                        }
//                    } else {
//                        XCTAssertTrue(false, "Cannot get level")
//                    }
//
//                }
//            } else {
//                XCTAssertTrue(false, "Cannot get level count")
//            }
//        }
//    }

}
