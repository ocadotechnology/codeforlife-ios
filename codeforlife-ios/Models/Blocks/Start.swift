//
//  Start.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 08/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Start: Block {
    init() {
        super.init(
            description: "Start",
            type: "start",
            color: kC4LBlocklyStartBlockColour)
    }
    
    override func submit() {
        CommandFactory.NativeResetAnimationCommand().execute()
    }
    
    override func submitMock() {
        CommandFactory.NativeAddAnimationCommand(StartAnimation()).execute()
    }
    
}