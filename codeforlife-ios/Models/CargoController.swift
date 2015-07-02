//
//  CargoController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class CargoController: VehicleController {
    
    
    var gameViewController: GameViewController
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    func moveForward() {
        GameViewCommandFactory.MoveForwardCommand().execute()
    }
    
    func turnLeft() {
        GameViewCommandFactory.TurnLeftCommand().execute()
    }
    
    func turnRight() {
        GameViewCommandFactory.TurnRightCommand().execute()
    }
    
    func go() {
        GameViewCommandFactory.PlayCommand().execute()
    }
    
}