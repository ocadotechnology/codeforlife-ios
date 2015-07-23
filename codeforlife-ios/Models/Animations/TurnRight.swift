//
//  TurnRight.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class TurnRightAnimation: MovementAnimation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Turn Right")
        self.turnRight(GameMapConfig.GridSize.height*(33+24+44+22)/202, duration: 0.7) {
            completion?()
        }
        object.turnRight()
    }
    
}


