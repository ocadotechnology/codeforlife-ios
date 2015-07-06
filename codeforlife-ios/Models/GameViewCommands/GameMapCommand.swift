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
    
}

class NGVMoveForwardCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.map?.player.moveForward()
    }
}

class NGVTurnLeftCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.map?.player.turnLeft()
    }
}

class NGVTurnRightCommand: GameMapCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.map?.player.turnRight()
    }
}