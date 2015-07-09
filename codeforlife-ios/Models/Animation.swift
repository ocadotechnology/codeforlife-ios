//
//  Animation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 09/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class Animation {
    
    var nextAnimation: Animation?
    
    func executeAnimation(completion: (() -> Void)? = nil) {
        fatalError("Implement executeanimation()")
    }
    
    func executeChainAnimation(completion: (() -> Void)? = nil) {
        executeAnimation {
            self.nextAnimation?.executeChainAnimation(completion: completion)
        }
    }
}

class MoveFoward: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        CommandFactory.NativeMoveForwardCommand()
    }
    
}

class TurnLeft: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        CommandFactory.NativeTurnLeftCommand()
    }
    
}

class TurnRight: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        CommandFactory.NativeTurnRightCommand()
    }
    
}