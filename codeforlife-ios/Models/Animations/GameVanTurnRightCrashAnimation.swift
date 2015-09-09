//
//  TurnRightCrashAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class GameVanTurnRightCrashAction: Animation {
    override func execute(completion: (() -> Void)? = nil) {
        println("Van Turn Right and Crash")
        delegate?.vanCrashRight(completion)
    }
    
}
