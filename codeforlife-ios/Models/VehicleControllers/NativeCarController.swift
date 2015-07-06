//
//  NativeController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class NativeCarController: VehicleController {
    
    var car : Van
    var gameViewController: GameViewController
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
        car = gameViewController.gameMapViewController!.map!.player
    }
    
    func moveForward() {
        CommandFactory.NativeAddBlockCommand(Forward()).execute()
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        car.moveForward(GameMapConfig.Grid.height, duration: 0.5) {
            CommandFactory.NativeEnableDirectDriveCommand().execute()
        }
    }
    
    func turnLeft() {
        CommandFactory.NativeAddBlockCommand(Left()).execute()
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        car.turnLeft(GameMapConfig.Grid.height*(33+24+22)/202, duration: 0.7) {
            gameViewController.directDriveViewController?.enableDirectDrive()
        }
    }
    
    func turnRight() {
        CommandFactory.NativeAddBlockCommand(Right()).execute()
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        car.turnRight(GameMapConfig.Grid.height*(33+24+44+22)/202, duration: 0.7) {
            gameViewController.directDriveViewController?.enableDirectDrive()
        }
    }
    
    func go() {
    }
    
}