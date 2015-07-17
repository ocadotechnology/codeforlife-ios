//
//  MoveForward.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class MoveForwardAnimation: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Move Forward")
        van?.moveForward(animated: true, completion: completion)
    }
    
}