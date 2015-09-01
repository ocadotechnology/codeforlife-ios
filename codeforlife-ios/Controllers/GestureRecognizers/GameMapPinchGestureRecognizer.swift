//
//  GameMapPinchGestureRecognizer.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class GameMapPinchGestureREcognizer: UIPinchGestureRecognizer {
    unowned var viewController: GameMapViewController
    var lastScale = CGFloat(1)
    var currentScale = CGFloat (1) {
        willSet {
            if let map = viewController.map {
                lastScale = currentScale
            }
        }
        didSet {
            if let map = viewController.map {
                map.size = CGSizeMake(map.size.width * lastScale / currentScale, map.size.height * lastScale / currentScale)
            }
        }
    }
    
    init(viewController: GameMapViewController) {
        self.viewController = viewController
        super.init(target: viewController, action: Selector("handlePinchGesture:"))
        viewController.view.addGestureRecognizer(self)
    }
    
    func handlePinchGesture(sender:UIPinchGestureRecognizer) {
        currentScale += (sender.scale - 1)/2
        currentScale = max(min(currentScale, 2), 1)
        sender.scale = 1
    }
}
