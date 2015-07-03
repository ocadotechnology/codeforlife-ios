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
    
    var skView: GameMapView?
    
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
        skView = GameMapView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        view.addSubview(skView!)
        skView?.showsFPS = true
        skView?.showsNodeCount = true
        skView?.ignoresSiblingOrder = true
        skView?.map = Map(width: 5, height: 5, size: frame.size)
        skView?.map?.size = frame.size
        skView?.map!.scaleMode = .ResizeFill
        skView?.presentScene(skView?.map)
        skView?.map?.draw()
        
    }

}
