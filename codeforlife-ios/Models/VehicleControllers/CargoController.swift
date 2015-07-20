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
        CommandFactory.NativeAddBlockCommand(Forward()).execute()
    }
    
    func turnLeft() {
        CommandFactory.NativeAddBlockCommand(Left()).execute()
    }
    
    func turnRight() {
        CommandFactory.NativeAddBlockCommand(Right()).execute()
    }
    
    func go() {
        SharedContext.MainGameViewController?.gameMenuViewController?.delegate.play()
    }
    
    func deliver() {
        CommandFactory.NativeAddBlockCommand(Deliver()).execute()
    }
    
//    deinit { println("WebViewVehicleController is being deallocated") }
    
}