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
    
    lazy var skView = SKView()
    lazy var animationHandler = AnimationHandler()
    
    var map: Map? {
        didSet {
            map?.removeAllChildren()
            skView.presentScene(map!)
            map?.draw()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = skView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
    }
    
//    deinit { println("GameMapViewController is being deallocated") }
}
