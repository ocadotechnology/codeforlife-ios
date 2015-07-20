//
//  MoveForward.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class MoveForwardAnimation: MovementAnimation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Move Forward")
        self.moveForward(GameMapConfig.Grid.height, duration: 0.5) {
            completion?()
        }
        object.moveForward()
    }
    
}