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
    
    override func executeBlockAnimation(player: MovableGameObject?, completion: (() -> Void)?) {
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        MoveForwardAnimation(object: player!).executeAnimation {
            CommandFactory.NativeEnableDirectDriveCommand().execute()
            completion?()
        }
    }
    
    override func executeBlockAction() {
        SharedContext.MainGameViewController?.gameMapViewController?.map?.van.moveForward()
        super.executeBlockAction()
    }
    
}