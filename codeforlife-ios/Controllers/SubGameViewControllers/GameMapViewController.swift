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
    
    var skView = SKView()
    var map: Map? {
        didSet {
            map?.removeAllChildren()
            map!.scaleMode = .ResizeFill
            skView.presentScene(map!)
            map?.draw()
        }
    }
    
    var animationQueue: [Animation] = [] {
        didSet {
            animationQueue.first?.executeChainAnimation()
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
    
    deinit {
        println("GameMapViewController is being deallocated")
    }

}
