//
//  CargoController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class CargoController: VehicleController {
    
    func moveForward() {
        CommandFactory.MoveForwardCommand().execute()
    }
    
    func turnLeft() {
        CommandFactory.TurnLeftCommand().execute()
    }
    
    func turnRight() {
        CommandFactory.TurnRightCommand().execute()
    }
    
    func go() {
        CommandFactory.PlayCommand().execute()
    }
    
}