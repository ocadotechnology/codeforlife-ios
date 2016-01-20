//
//  GameMapViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit

public class GameMapViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: SKView!
    
    public var animationHandler: AnimationHandler?
    public weak var gvcDelegate: GameViewControllerDelegate?
    
    public var mapScene: MapScene? {
        didSet {
            loadMap()
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
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
    
    override public func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.presentScene(nil)
        mapScene?.removeAllChildren()
        mapScene?.removeFromParent()
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if let mapScene = mapScene {
            mapScene.kamera.position = CGPointMake(mapScene.size.width/2 + scrollView.contentOffset.x, mapScene.size.height/2 - scrollView.contentOffset.y)
            mapScene.centerOnNode(mapScene.kamera)
        }
    }
    
//    deinit { println("GameMapViewController is being deallocated") }
    
}