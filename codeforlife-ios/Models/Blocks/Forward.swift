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
            color: kC4LBlocklyForwardBlockColour)
    }
    
    override func executeBlockAction(player: MovableGameObject, completion: (() -> Void)? = nil) {
        player.moveForward {
            super.executeBlockAction(player, completion: completion)
        }
    }
    
    override func submit() {
        CommandFactory.WebViewMoveForwardCommand().execute()
        StaticContext.MainGameViewController?.gameMapViewController.animationQueue.append(MoveForward())
    }
}