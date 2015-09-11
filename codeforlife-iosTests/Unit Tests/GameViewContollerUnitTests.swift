//
//  GameViewContollerUnitTests.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 11/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Quick
import Nimble
import codeforlife_ios

class GameViewControllerUnitTests: QuickSpec {
    
    let mockLevelUrl = "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/levels/1/"
    var gameViewController: GameViewController!
    
    override func spec() {
        
        describe(".viewDidAppear") {
            
            describe("When GameViewController has finished loading the views") {
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    self.gameViewController = storyboard.instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
                    let window = UIWindow(frame: UIScreen.mainScreen().bounds)
                    window.makeKeyAndVisible()
                    window.rootViewController = self.gameViewController
                }
                
                it("should have a BlocklyViewController") {
                    expect(self.gameViewController.blockTableViewController).toNot(beNil())
                }
    
                it("should have a GameMapViewController") {
                    expect(self.gameViewController.gameMapViewController).toNot(beNil())
                }
                
                it("should have a GameMenuViewController") {
                    expect(self.gameViewController.gameMenuViewController).toNot(beNil())
                }
                
                it("GameViewController and GameViewInteractionHandler share the same delegate") {
                    expect(self.gameViewController.gvcDelegate).to(beIdenticalTo(self.gameViewController.gameViewInteractionHandler.gvcDelegate))
                }
                
                it("GameViewController and BlocklyViewController should share the same delegate") {
                    expect(self.gameViewController.gvcDelegate).to(beIdenticalTo(self.gameViewController.blockTableViewController!.gvcDelegate))
                }
                
                it ("GameViewController and GameMenuViewController should share the same delegate") {
                    expect(self.gameViewController.gvcDelegate).to(beIdenticalTo(self.gameViewController.gameMenuViewController!.gvcDelegate))
                }
                
                it ("GameViewController and GameMapViewController should share the same delegate") {
                    expect(self.gameViewController.gvcDelegate).to(beIdenticalTo(self.gameViewController.gameMenuViewController!.gvcDelegate))
                }
                
                it ("Webview should have a navitagionDelegate") {
                    expect(self.gameViewController.webView).toNot(beNil())
                }
                
            }
            
        }
        
        describe(".loadLevel") {
            context("When levelUrl changes to the url for level 1") {
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    self.gameViewController = storyboard.instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
                    let window = UIWindow(frame: UIScreen.mainScreen().bounds)
                    window.makeKeyAndVisible()
                    window.rootViewController = self.gameViewController
                    self.gameViewController.levelUrl = self.mockLevelUrl
                }
                
                
            }
        }
        
    }
    
}
