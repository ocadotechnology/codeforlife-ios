//
//  Deliver.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 08/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Deliver: Block {
    init() {
        super.init(
            description: "Deliver",
            color: kC4LBlocklyDeliverBlockColour)
    }
    
    override func executeBlockAction(player: MovableGameObject, completion: (() -> Void)? = nil) {
        player.deliver {
            super.executeBlockAction(player, completion: completion)
        }
    }
    
    override func submit() {
        CommandFactory.WebViewDeliverCommand().execute()
        StaticContext.MainGameViewController?.gameMapViewController.map?.player.deliver()
    }
}