//
//  LaunchScreenViewControllerUITests.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import KIF
import UIKit
import XCTest

class UI1LaunchScreenViewControllerUITests: KIFTestCase {
    
    func test1StartButtonMoveToEpisodeList() {
        pressStart()
        assertMovedToEpisodeViewController()
    }
    
}

extension KIFTestCase {
    func pressStart() {
        tester.tapViewWithAccessibilityLabel("Start")
    }
    
    func assertMovedToEpisodeViewController() {
        tester.waitForAbsenceOfViewWithAccessibilityLabel("Start")
    }
}
