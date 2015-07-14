//
//  TurnRight.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class TurnRight: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        CommandFactory.NativeTurnRightCommand().execute(completion: completion)
    }
    
}

class DeliverAnimation: Animation {
    
    override func executeAnimation(completion: (() -> Void)? = nil) {
        CommandFactory.NativeDeliverCommand().execute(completion: completion)
    }
}
