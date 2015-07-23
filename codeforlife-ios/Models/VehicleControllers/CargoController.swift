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
        ActionFactory.createAction("AddMoveForwardBlock").execute()
    }
    
    func turnLeft() {
        ActionFactory.createAction("AddTurnLeftBlock").execute()
    }
    
    func turnRight() {
        ActionFactory.createAction("AddTurnRightBlock").execute()
    }
    
    func go() {
        SharedContext.MainGameViewController?.gameMenuViewController?.delegate.play()
    }
    
    func deliver() {
        ActionFactory.createAction("AddDeliverBlock").execute()
    }
    
//    deinit { println("WebViewVehicleController is being deallocated") }
    
}