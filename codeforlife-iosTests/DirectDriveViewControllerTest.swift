//
//  DirectDriveViewControllerTest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class DirectDriveViewControllerTest: XCTestCase {

    var storyboard: UIStoryboard?
    var gameViewController : GameViewController?
    
    let level = Level("1", "Title", "url")
    
    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        gameViewController = storyboard?.instantiateViewControllerWithIdentifier("GameViewController") as? GameViewController
//        gameViewController!.setupWebView()
//        gameViewController!.loadLevel(level)
//        gameViewController!.setupDirectDriveViewController()
//        gameViewController!.handler = GameViewMockInteractionHandler()
//        gameViewController!.handler.gameViewController = gameViewController!
    }

//    func testCargoController() {
//        var handler = gameViewController!.handler as! GameViewMockInteractionHandler
//        var cargoController = gameViewController!.directDriveViewController!.controller
//        cargoController = CargoController(gameViewController: gameViewController!)
//        
//        var expectation = expectationWithDescription("moveForward")
//        handler.callback = { (tag) in
//            if expectation?.description == tag {
//                expectation?.fulfill()
//            }
//        }
//        cargoController!.moveForward()
//        waitForExpectationsWithTimeout(5) { (error) -> Void in
//            if error != nil {
//                println(error)
//            }
//        }
//    }


}
