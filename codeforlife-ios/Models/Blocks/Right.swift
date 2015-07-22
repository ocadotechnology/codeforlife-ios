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
    
    override func executeBlockAnimation(player: MovableGameObject?, completion: (() -> Void)?) {
        
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        TurnRightAnimation(object: player!).executeAnimation {
            CommandFactory.NativeEnableDirectDriveCommand().execute()
            completion?()
        }
    }
    
    override func executeBlockAction() {
        SharedContext.MainGameViewController?.gameMapViewController?.map?.van.turnRight()
        super.executeBlockAction()
    }

}