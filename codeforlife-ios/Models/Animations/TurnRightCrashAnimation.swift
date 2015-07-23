//
//  TurnRightCrashAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class TurnRightCrashAnimation: MovementAnimation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Turn Right and Crash")
        self.turnRight(GameMapConfig.GridSize.height*(33+24+44+22)/202, duration: 0.7) {
            ExplodeAnimation().executeAnimation(completion: completion)
        }
        object.turnRight()
    }
    
}
