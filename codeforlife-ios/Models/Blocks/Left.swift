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
    
    override func executeBlockAnimation(player: MovableGameObject?, completion: (() -> Void)?) {
        
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        TurnLeftAnimation(object: player!).executeAnimation {
            CommandFactory.NativeEnableDirectDriveCommand().execute()
            completion?()
        }
    }
    
    override func executeBlockAction() {
        SharedContext.MainGameViewController?.gameMapViewController?.map?.van.turnLeft()
        super.executeBlockAction()
    }
    
    override func toString() -> String {
        return "\"turn_left\","
    }
    
}