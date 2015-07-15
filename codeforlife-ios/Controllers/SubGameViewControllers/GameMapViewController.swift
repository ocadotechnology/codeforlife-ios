//
//  GameMapViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit

class GameMapViewController: SubGameViewController, UIScrollViewDelegate {
    
    var map: Map? {
        didSet {
            map?.removeAllChildren()
            map!.scaleMode = .ResizeFill
            skView.presentScene(map!)
            map?.draw()
        }
    }
    
    lazy var skView = SKView()
    lazy var animationQueue: [Animation] = [Animation]()
    
    var shouldRunAnimation = false {
        didSet {
            println("shouldRunAnimation = \(shouldRunAnimation)")
            if shouldRunAnimation {
                
                // reset animations if all animations are run
                if currentAnimationIndex >= animationQueue.count {
                    self.currentAnimationIndex = 0
                    self.map?.player.resetPosition()
                }
                
                // run one animation and trigger next animation if 
                // shouldRunAnimation is still true by the time animnation finishes
                isAnimationRunning = true
                animationQueue[currentAnimationIndex++].executeAnimation {
                    [unowned self] in
                    
                    // Temp solution
                    // show result if the all animations are run
                    // terminate the animation process
                    if self.currentAnimationIndex == self.animationQueue.count {
                        CommandFactory.NativeShowResultCommand().execute {
                            [unowned self] in
                            self.shouldRunAnimation = false
                        }
                    }
                    
                    // Notify there is no animation running
                    // and decide if it should run the next animation
                    self.isAnimationRunning = false
                }
            }
        }
    }
    
    var isAnimationRunning = false {
        didSet {
            println("isAnimationRunning = \(isAnimationRunning)")
            if !isAnimationRunning {
                 shouldRunAnimation = shouldRunAnimation.boolValue
            }
        }
    }
    
    var currentAnimationIndex = 0 {
        didSet {
            
            println("currentAnimationIndex = \(currentAnimationIndex), count = \(animationQueue.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = skView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
    }
    
    func pause() {
        skView.paused = true
        map?.paused = true
    }
    
    func unpause() {
        skView.paused = false
        map?.paused = false
    }
    
    deinit { println("GameMapViewController is being deallocated") }
}
