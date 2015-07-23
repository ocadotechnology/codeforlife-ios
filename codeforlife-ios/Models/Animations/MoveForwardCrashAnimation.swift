//
//  MoveForwardCrashAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class MoveForwardCrashAnimation: MovementAnimation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Move Forward and Crash")
        self.moveForward(GameMapConfig.GridSize.height, duration: 0.5) {
            ExplodeAnimation().executeAnimation(completion: completion)
        }
        object.moveForward()
    }
    
}