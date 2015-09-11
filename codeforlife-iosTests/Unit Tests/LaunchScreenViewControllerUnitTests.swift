//
//  LaunchScreenViewControllerUnitTests.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Quick
import Nimble
import codeforlife_ios

class LaunchScreenViewControllerUnitTests: QuickSpec {
    
    var launchScreenViewController: LaunchScreenViewController!
    
    override func spec() {
        
        describe(".viewDidAppear") {
            
            describe("When the view controller has finished loading the views") {
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    self.launchScreenViewController = storyboard.instantiateInitialViewController() as! LaunchScreenViewController
                    let window = UIWindow(frame: UIScreen.mainScreen().bounds)
                    window.makeKeyAndVisible()
                    window.rootViewController = self.launchScreenViewController
                    
                    
                }
                
                it("should have a start button") {
                    expect(self.launchScreenViewController?.startButton).toNot(beNil())
                }
            }
            
        }
        
    }
    
}


