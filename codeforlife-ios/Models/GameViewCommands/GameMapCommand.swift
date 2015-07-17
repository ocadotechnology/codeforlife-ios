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
        return gameViewController.gameMapViewController?.map
    }
    
    weak var viewController : GameMapViewController? {
        return gameViewController.gameMapViewController
    }
}

class NGVMoveForwardCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        map?.player.moveForward {
            completion?()
        }
    }
}

class NGVTurnLeftCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        map?.player.turnLeft {
            completion?()
        }
    }
}

class NGVTurnRightCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        map?.player.turnRight {
            completion?()
        }
    }
}

class NGVDeliverCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        map?.player.deliver{
            completion?()
        }
    }
}

class NGVShowResultCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        if map!.visitedAllDestinations() {
            CommandFactory.NativeShowPostGameMessageCommand().execute { completion?() }
        } else {
            CommandFactory.NativeShowFailMessageCommand().execute { completion?() }
        }
    }
}

class NGVResetAnimationCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.gameMapViewController?.animationHandler.removeAllAnimations()
    }
}

