//
//  NativeController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class NativeCarController: VehicleController {
    
    var car : Van
    
    init(gameViewController: GameViewController) {
        car = gameViewController.gameMapViewController!.skView!.map!.player
    }
    
    func moveForward() {
        car.moveForward(50, duration: 0.5)
    }
    
    func turnLeft() {
        car.turnLeft(50, duration: 1)
    }
    
    func turnRight() {
        car.turnRight(50, duration: 1)
    }
    
    func go() {
    }
    
}