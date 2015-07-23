//
//  StartEngineAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class StartEngineAnimation: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        SharedContext.MainGameViewController?.gameMapViewController?.map?.van.engine.play()
        completion?()
    }
}