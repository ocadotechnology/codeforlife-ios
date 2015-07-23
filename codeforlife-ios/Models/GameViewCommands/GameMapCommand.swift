//
//  GameMapCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class GameMapCommand: GameViewCommand {
    
    weak var map : Map? {
        return gameViewController?.gameMapViewController?.map
    }
    
    weak var viewController : GameMapViewController? {
        return gameViewController?.gameMapViewController
    }
}

class GameMapResetAnimationCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.animationHandler.removeAllAnimations()
    }
}

