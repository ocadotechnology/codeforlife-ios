//
//  CargoController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class WebViewVehicleController: VehicleController {
    
    func moveForward() {
        CommandFactory.createCommand("AddMoveForwardBlock").execute()
    }
    
    func turnLeft() {
        CommandFactory.createCommand("AddTurnLeftBlock").execute()
    }
    
    func turnRight() {
        CommandFactory.createCommand("AddTurnRightBlock").execute()
    }
    
    func go() {
        SharedContext.MainGameViewController?.gameMenuViewController?.delegate.play()
    }
    
    func deliver() {
        CommandFactory.createCommand("AddDeliverBlock").execute()
    }
    
//    deinit { println("WebViewVehicleController is being deallocated") }
    
}