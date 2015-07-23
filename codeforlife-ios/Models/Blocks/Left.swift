//
//  Left.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 08/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Left: Block {
    
    init() {
        super.init(
            description: "Turn Left",
            type: "\"turn_left\",",
            color: kC4LBlocklyLeftBlockColour)
    }
    
    override func executeBlock(#animated: Bool, completion: (() -> Void)?) {
        CommandFactory.createCommand("DisableDirectDrive").execute()
        van?.turnLeft(animated: animated, completion: {
            CommandFactory.createCommand("EnableDirectDrive").execute()
            completion?()
        })
    }
    
}