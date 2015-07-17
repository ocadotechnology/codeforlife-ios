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
    
    override func executeBlockAction(player: MovableGameObject, completion: (() -> Void)? = nil) {
        player.turnLeft {
            super.executeBlockAction(player, completion: completion)
        }
    }
    
    override func toString() -> String {
        return "\"turn_left\","
    }
    
    override func submit() {
        CommandFactory.WebViewTurnLeftCommand().execute()
    }
    
//    override func submitMock() {
//        CommandFactory.WebViewTurnLeftCommand().execute()
//        CommandFactory.NativeAddAnimationCommand(TurnLeftAnimation()).execute()
//    }
}