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
    override func executeWithCompletionHandler(completion: () -> Void) {
        CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStepControls).execute()
        map?.player.moveForward {
            CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStopControls).execute()
            completion()
        }
    }
}

class NGVTurnLeftCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStepControls).execute()
        map?.player.turnLeft {
            CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStopControls).execute()
            completion()
        }
    }
}

class NGVTurnRightCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStepControls).execute()
        map?.player.turnRight {
            CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStopControls).execute()
            completion()
        }
    }
}

class NGVDeliverCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        map?.player.deliver{
            completion()
        }
    }
}

class NGVShowResultCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        if map!.visitedAllDestinations() {
            CommandFactory.NativeShowPostGameMessageCommand().execute()
        } else {
            CommandFactory.NativeShowFailMessageCommand().execute()
        }
        CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStopControls).execute()
    }
}

class NGVPauseAnimationCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.pause()
    }
}

class NGVUnpauseAnimationCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.unpause()
    }
}

class NGVAddAnimationCommand : GameMapCommand {
    
    var animation: Animation
    
    init(_ gameViewController: GameViewController, _ animation: Animation) {
        self.animation = animation
        super.init(gameViewController : gameViewController)
    }
    
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.animationQueue.append(self.animation)
    }
}

class NGVResetAnimationCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.animationQueue = [Animation]()
    }
}

