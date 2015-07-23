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

class TurnLeftCrashAnimation: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Turn Left and Crash")
        van?.turnLeft(animated: true, completion: {
            [weak van] in
            van?.crash(completion)
        })
    }
    
}