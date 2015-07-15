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
            CommandFactory.NativeShowPostGameMessageCommand().execute()
        } else {
            CommandFactory.NativeShowFailMessageCommand().execute()
        }
    }
}

class NGVPauseAnimationCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.gameMapViewController?.pause()
    }
}

class NGVUnpauseAnimationCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.gameMapViewController?.unpause()
    }
}

class NGVAddAnimationCommand : GameMapCommand {
    
    var animation: Animation
    
    init(_ gameViewController: GameViewController, _ animation: Animation) {
        self.animation = animation
        super.init(gameViewController : gameViewController)
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.gameMapViewController?.animationQueue.last?.nextAnimation = self.animation
        gameViewController.gameMapViewController?.animationQueue.append(self.animation)
    }
}

class NGVResetAnimationCommand: GameMapCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.gameMapViewController?.animationQueue.removeAll(keepCapacity: false)
    }
}

