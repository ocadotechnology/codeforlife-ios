//
//  TurnLeftCrashAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class TurnLeftCrashAnimation: MovementAnimation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Turn Left and Crash")
        self.turnLeft(GameMapConfig.Grid.height*(33+24+22)/202, duration: 0.5) {
            ExplodeAnimation().executeAnimation(completion: completion)
        }
        object.turnLeft()
    }
    
}