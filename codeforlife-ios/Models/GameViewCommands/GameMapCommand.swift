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
    var map : Map? {
        return gameViewController.gameMapViewController.map
    }
}

class NGVMoveForwardCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        self.gameViewController.gameMenuViewController.controlMode = .onStepControls
        map?.player.moveForward {
            self.gameViewController.gameMenuViewController.controlMode = .onStopControls
            completion()
        }
    }
}

class NGVTurnLeftCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        self.gameViewController.gameMenuViewController.controlMode = .onStepControls
        map?.player.turnLeft {
            self.gameViewController.gameMenuViewController.controlMode = .onStopControls
            completion()
        }
    }
}

class NGVTurnRightCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        self.gameViewController.gameMenuViewController.controlMode = .onStepControls
        map?.player.turnRight {
            self.gameViewController.gameMenuViewController.controlMode = .onStopControls
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
        self.gameViewController.gameMenuViewController.controlMode = .onStopControls
    }
}

class NGVPauseAnimationCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController.pause()
    }
}

class NGVUnpauseAnimationCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController.unpause()
    }
}