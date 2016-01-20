//
//  GameVanStartEngineAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class GameVanStartEngineAction: Animation {
    override func execute(completion: (() -> Void)? = nil) {
        print("Starting Engine")
        delegate?.vanStartEngine(completion)
    }
}