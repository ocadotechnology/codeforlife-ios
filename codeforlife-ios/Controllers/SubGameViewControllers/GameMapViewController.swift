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
    
    static let sharedInstance = StaticContext.storyboard.instantiateViewControllerWithIdentifier("GameMapViewController") as! GameMapViewController
    
    var skView: GameMapView?
    var map: Map? {
        didSet {
            map?.removeAllChildren()
            map?.size = frame.size
            map!.scaleMode = .ResizeFill
            skView?.presentScene(map!)
            map?.draw()
        }
    }
    
    override var frame: CGRect {
        get {
            let controller = StaticContext.MainGameViewController!
            return CGRect(
                x: controller.view.frame.width * (1 - controller.webViewPortion) + controller.webViewOffset,
                y: controller.webViewOffset,
                width: controller.view.frame.width * controller.webViewPortion - 2 * controller.webViewOffset,
                height: controller.view.frame.height - 2 * controller.webViewOffset)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView = GameMapView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        view.addSubview(skView!)
        skView?.showsFPS = true
        skView?.showsNodeCount = true
        skView?.ignoresSiblingOrder = true
    }

}
