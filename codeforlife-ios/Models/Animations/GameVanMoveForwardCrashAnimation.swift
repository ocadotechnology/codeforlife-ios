//
//  MoveForwardCrashAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class GameVanMoveForwardCrashAction: Animation {
    override func execute(completion: (() -> Void)? = nil) {
        print("Van Move Forward and Crash")
        delegate?.vanCrashForward(completion)
    }
}