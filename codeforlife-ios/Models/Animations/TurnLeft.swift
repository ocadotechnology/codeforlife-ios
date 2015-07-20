//
//  File.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class TurnLeftAnimation: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Turn Left")
        CommandFactory.NativeTurnLeftCommand().execute(completion: completion)
    }
    
}
