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
        gameViewController.blockTableViewController?.addBlock(Forward())
        gameViewController.directDriveViewController?.disableDirectDrive()
        car.moveForward(GameMapConfig.Grid.height, duration: 0.5) {
            gameViewController.directDriveViewController?.enableDirectDrive()
        }
    }
    
    func turnLeft() {
        gameViewController.blockTableViewController?.addBlock(Left())
        gameViewController.directDriveViewController?.disableDirectDrive()
        car.turnLeft(GameMapConfig.Grid.height*(33+24+22)/202, duration: 0.7) {
            gameViewController.directDriveViewController?.enableDirectDrive()
        }
    }
    
    func turnRight() {
        gameViewController.blockTableViewController?.addBlock(Right())
        gameViewController.directDriveViewController?.disableDirectDrive()
        car.turnRight(GameMapConfig.Grid.height*(33+24+44+22)/202, duration: 0.7) {
            gameViewController.directDriveViewController?.enableDirectDrive()
        }
    }
    
    func go() {
    }
    
}