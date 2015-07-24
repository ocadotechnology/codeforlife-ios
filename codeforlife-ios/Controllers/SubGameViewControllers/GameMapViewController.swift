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
    
    lazy var animationHandler = AnimationHandler()
    
    var map: Map? {
        didSet {
            loadMap()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = GameView()
        let gameView = self.view as! GameView
        gameView.backgroundColor = kC4LGameMapGrassColor
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        gameView.ignoresSiblingOrder = true
        loadMap()
    }
    
    private func loadMap() {
        if let map = self.map,
            gameView = self.view as? GameView {
            gameView.presentScene(map)
            map.backgroundColor = kC4LGameMapGrassColor
            map.removeAllChildren()
            map.draw()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let gameView = self.view as! GameView
        gameView.presentScene(nil)
        map?.removeAllChildren()
        map?.removeFromParent()
    }
    
    deinit { println("GameMapViewController is being deallocated") }
}

class GameView: SKView {
    deinit {
        println("GameView is being deallocated")
    }
}