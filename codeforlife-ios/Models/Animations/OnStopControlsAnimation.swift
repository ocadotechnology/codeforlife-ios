//
//  onStopControlsAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class OnStopControlsAnimation: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("OnStopControls")
        CommandFactory.createCommand("ChangeToOnStopControls").execute(completion: completion)
    }
}