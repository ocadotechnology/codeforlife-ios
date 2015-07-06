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
    
    var gameViewController: GameViewController
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
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
    }
    
}