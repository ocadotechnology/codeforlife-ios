//
//  File.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class TurnLeftAnimation: MovementAnimation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Turn Left")
        self.turnLeft(GameMapConfig.Grid.height*(33+24+22)/202, duration: 0.5) {
            completion?()
        }
        object.turnLeft()
    }
    
}
