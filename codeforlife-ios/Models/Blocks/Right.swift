//
//  Right.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 08/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Right: Block {
    init() {
        super.init(
            description: "Right",
            type: "\"turn_right\",",
            color: kC4LBlocklyRightBlockColour)
    }
    
    override func executeBlock(#animated: Bool, completion: (() -> Void)?) {
        CommandFactory.createCommand("DisableDirectDrive").execute()
        van?.turnRight(animated: animated, completion: {
            CommandFactory.createCommand("EnableDirectDrive").execute()
            completion?()
        })
    }

}