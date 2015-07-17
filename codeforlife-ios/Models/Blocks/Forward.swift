//
//  Forward.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 08/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Forward: Block {
    init() {
        super.init(
            description: "Move Forward",
            type: "\"move_forwards\",",
            color: kC4LBlocklyForwardBlockColour)
    }
    
    override func executeBlock(#animated: Bool, completion: (() -> Void)?) {
        ActionFactory.createAction("DisableDirectDrive").execute()
        van?.moveForward(animated: animated, completion: {
            ActionFactory.createAction("EnableDirectDrive").execute()
            completion?()
        })
    }
    
}