//
//  LevelViewControllerUITests.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import KIF
import UIKit
import XCTest

class T3LevelViewControllerUITests: KIFTestCase {

    func testEpisodeOne() {
        gotoEpisode(1)
        assertTheNumberOfLevelInThisEpisodeShouldBe(12)
        goBackToEpisodeList()
    }
    
    func testEpisodeTwo() {
        gotoEpisode(2)
        assertTheNumberOfLevelInThisEpisodeShouldBe(6)
        goBackToEpisodeList()
    }
    
}

extension KIFTestCase {
    
    func assertTheNumberOfLevelInThisEpisodeShouldBe(numberOfLevels: Int) {
        tester.waitForCellAtIndexPath(NSIndexPath(forRow: numberOfLevels-1, inSection: 0), inTableViewWithAccessibilityIdentifier: "LevelList")
    }
    
    func goBackToEpisodeList() {
        tester.tapViewWithAccessibilityLabel("Back")
    }
    
}
