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
            color: kC4LBlocklyRightBlockColour)
    }
    
    override func executeBlockAction(player: MovableGameObject, completion: (() -> Void)? = nil) {
        player.turnRight {
            super.executeBlockAction(player, completion: completion)
        }
    }
    
    override func submit() {
        CommandFactory.WebViewTurnRightCommand().execute()
        StaticContext.MainGameViewController?.gameMapViewController.animationQueue.append(TurnRight())
    }
}