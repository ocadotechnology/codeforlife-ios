//
//  EpisodeViewControllerUITests.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import KIF
import UIKit
import XCTest

class UI2EpisodeViewControllerUITests: KIFTestCase {
    
    func test1NumberOfEpisodes() {
        assertThereShouldBeTwoEpisodes()
    }

}

extension KIFTestCase {
    
    func gotoEpisode(episode: Int) {
        tester.tapRowAtIndexPath(NSIndexPath(forRow: episode-1, inSection: 0), inTableViewWithAccessibilityIdentifier: "EpisodeList")
    }
    
    func assertThereShouldBeTwoEpisodes() {
        tester.waitForCellAtIndexPath(NSIndexPath(forRow: 1, inSection: 0), inTableViewWithAccessibilityIdentifier: "EpisodeList")
    }
}
