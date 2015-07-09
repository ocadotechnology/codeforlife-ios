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
        CommandFactory.NativeMoveForwardCommand().execute()
        CommandFactory.NativeAddBlockCommand(Forward()).execute()
    }
    
    func turnLeft() {
        CommandFactory.NativeTurnLeftCommand().execute()
        CommandFactory.NativeAddBlockCommand(Left()).execute()
    }
    
    func turnRight() {
        CommandFactory.NativeTurnRightCommand().execute()
        CommandFactory.NativeAddBlockCommand(Right()).execute()
    }
    
    func go() {
        CommandFactory.NativePlayCommand().execute()
        // Waiting for API to return me with something to execute all the animation in a row
    }
    
    func deliver() {
        CommandFactory.NativeAddBlockCommand(Deliver()).execute()
    }
    
}