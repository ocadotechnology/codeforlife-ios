//
//  BlockTableViewPanGestureRecognizer.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//
import SpriteKit
import UIKit
import Foundation

class GameMapPanGestureRecognizer: UIPanGestureRecognizer {
    
    let offset: CGFloat = 0.05
    var originalMapSize: CGSize?
    
    unowned var viewController: GameMapViewController

    init(viewController: GameMapViewController) {
        self.viewController = viewController
        super.init(target: viewController, action: Selector("handlePanGesture:"))
        viewController.view.addGestureRecognizer(self)
    }
    
    func handlePanGesture(sender:UIPanGestureRecognizer) {
        if let map = viewController.map {
            if let originalMapSize = originalMapSize {
                let offsetX = map.size.width - map.originalSize.width
                let offsetY = map.size.height - map.originalSize.height
                let movement = sender.translationInView(viewController.view)
                
                let newX = min(-offsetX, map.anchorPoint.x + movement.x/1000)
                let newY = min(-offsetY, map.anchorPoint.y - movement.y/1000)
                viewController.map?.anchorPoint = CGPointMake(newX, newY)
                sender.setTranslation(CGPointZero, inView: viewController.view)
            } else {
                originalMapSize = map.size
            }
        }
    }
}
