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
    
    var skView = SKView()
    var map: Map? {
        didSet {
            println("YOLO")
            map?.removeAllChildren()
            map!.scaleMode = .ResizeFill
            skView.frame = view.frame
            skView.presentScene(map!)
            map?.draw()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        view.addSubview(skView)
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
    }

}
