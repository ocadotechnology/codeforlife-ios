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
    
    func moveForward() {
        CommandFactory.NativeAddBlockCommand(Forward()).execute()
        CommandFactory.NativeMoveForwardCommand().execute()
    }
    
    func turnLeft() {
        CommandFactory.NativeAddBlockCommand(Left()).execute()
        CommandFactory.NativeTurnLeftCommand().execute()
    }
    
    func turnRight() {
        CommandFactory.NativeAddBlockCommand(Right()).execute()
        CommandFactory.NativeTurnRightCommand().execute()
    }
    
    func go() {
        CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onPlayControls)
    }
    
    func deliver() {
        CommandFactory.NativeAddBlockCommand(Deliver()).execute()
    }
    
}