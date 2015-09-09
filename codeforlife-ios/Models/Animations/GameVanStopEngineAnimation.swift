//
//  GameVanStopengineAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class GameVanStopEngineAction: Animation {
    override func execute(completion: (() -> Void)? = nil) {
        println("Stopping Engine")
        delegate?.vanStopEngine(completion)
    }
}