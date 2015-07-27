//
//  FetchEpisodesActionTest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class FetchEpisodesActionTest: XCTestCase {
    
    let episodeCount = 11
    
    var storyboard: UIStoryboard?

    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
    }

    func testDevDelegate() {
        
        let controller = storyboard!.instantiateViewControllerWithIdentifier("EpisodeViewController") as! EpisodeViewController
        let expectation = expectationWithDescription("Dev API Episode 1")
        
//        FetchEpisodesRequest(controller).switchToDev().execute {
//            expectation.fulfill()
//        }
        waitForExpectationsWithTimeout(10) { (error) -> Void in
            if error != nil {
                println(error)
            }
        }
        XCTAssertEqual(controller.episodes.count, episodeCount, "Episode count == 0")
        
    }
    
    func testMockDelegate() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("EpisodeViewController") as! EpisodeViewController
        let delegate = FetchLevelsRequestMockDelegate()
//        FetchEpisodesRequest(controller).switchToMock().execute {}
        XCTAssertEqual(controller.episodes.count, 4, "Episode count does not match")
    }

}
