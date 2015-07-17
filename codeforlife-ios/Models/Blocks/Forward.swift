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
    
    override func executeBlockAction(player: MovableGameObject, completion: (() -> Void)? = nil) {
        player.moveForward {
            super.executeBlockAction(player, completion: completion)
        }
    }
    
    override func toString() -> String {
        return "\"move_forwards\","
    }
    
    override func submit() {
        CommandFactory.WebViewMoveForwardCommand().execute()
    }
    
//    override func submitMock() {
//        CommandFactory.WebViewMoveForwardCommand().execute()
//        CommandFactory.NativeAddAnimationCommand(MoveForwardAnimation()).execute()
//    }
}