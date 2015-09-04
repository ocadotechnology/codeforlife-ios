//
//  GameMapViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit

class GameMapViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: SKView!
    
    var animationHandler: AnimationHandler?
    weak var gvcDelegate: GameViewControllerDelegate?
    
    var mapScene: MapScene? {
        didSet {
            loadMap()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsFPS = true
        mapView.showsNodeCount = true
        mapView.ignoresSiblingOrder = true
        scrollView.delegate = self
        animationHandler = AnimationHandler(delegate: gvcDelegate)
    }
    
    private func loadMap() {
        if let mapScene = self.mapScene {
            scrollView.contentSize = mapScene.size
            mapView.presentScene(mapScene)
            mapScene.constructWorld()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.presentScene(nil)
        mapScene?.removeAllChildren()
        mapScene?.removeFromParent()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let mapScene = mapScene {
            mapScene.camera.position = CGPointMake(mapScene.size.width/2 + scrollView.contentOffset.x, mapScene.size.height/2 - scrollView.contentOffset.y)
            mapScene.centerOnNode(mapScene.camera)
        }
    }
    
//    deinit { println("GameMapViewController is being deallocated") }
    
}