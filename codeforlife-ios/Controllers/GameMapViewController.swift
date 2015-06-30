//
//  GameMapViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit

class GameMapViewController: SubGameViewController {
    
    override var frame: CGRect {
        get {
            return CGRect(
                x: self.gameViewController!.view.frame.width * (1 - self.gameViewController!.webViewPortion) + self.gameViewController!.webViewOffset,
                y: self.gameViewController!.webViewOffset,
                width: self.gameViewController!.view.frame.width * self.gameViewController!.webViewPortion - 2 * self.gameViewController!.webViewOffset,
                height: self.gameViewController!.view.frame.height - 2 * self.gameViewController!.webViewOffset)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: frame.size)
        var skView = SKView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        view.addSubview(skView)
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        
    }

}
