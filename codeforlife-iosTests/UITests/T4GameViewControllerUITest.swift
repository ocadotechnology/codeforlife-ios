//
//  T4GameViewControllerUITest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import KIF
import UIKit
import XCTest

class T4GameViewControllerUITest: KIFTestCase {
    
    func test1Level1() {
        assertIAmAtEpisodeList()
        gotoEpisode(1)
        gotoLevel(1)
        assertThatIAmInLevel1()
        assertWebViewLoaded()
    }
    
    func test2Play() {
        pressPlay()
        assertPlayButtonBecomePauseButton()
        assertPlayWillDisableTrashCan()
        assertFailurePopupDueToNoInstruction()
        closePopup()
    }
    
}

extension KIFTestCase {
    
    func gotoLevel(level: Int) {
        tester.tapRowAtIndexPath(NSIndexPath(forRow: level - 1, inSection: 0), inTableViewWithAccessibilityIdentifier: "LevelList")
    }
    
    func assertThatIAmInLevel1() {
        tester.waitForViewWithAccessibilityLabel(AccessibilityIdentifier.MessageViewControllerCloseButton)
        tester.tapViewWithAccessibilityLabel(AccessibilityIdentifier.MessageViewControllerCloseButton)
    }
    
    func assertIAmAtEpisodeList() {
        tester.waitForCellAtIndexPath(NSIndexPath(forRow: 1, inSection: 0), inTableViewWithAccessibilityIdentifier: "EpisodeList")
    }
    
    func assertWebViewLoaded() {
        tester.waitForAbsenceOfViewWithAccessibilityLabel(AccessibilityIdentifier.Spinner)
    }
    
    func pressPlay() {
        tester.tapViewWithAccessibilityLabel("Play")
    }
    
    func assertPlayWillDisableTrashCan() {
        XCTAssertFalse((tester.waitForViewWithAccessibilityLabel("Clear") as! UIButton).enabled)
    }
    
    func assertFailurePopupDueToNoInstruction() {
        tester.waitForViewWithAccessibilityLabel("Try Again")
    }
    
    func closePopup() {
        tester.tapViewWithAccessibilityLabel("Try Again")
    }
    
    func assertPlayButtonBecomePauseButton() {
        // TODO : Need a workaround to get the image name of the button
    }
    
}
