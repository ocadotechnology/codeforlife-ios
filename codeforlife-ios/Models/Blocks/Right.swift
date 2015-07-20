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
    
    override func executeBlockAction(player: MovableGameObject?, completion: (() -> Void)? = nil) {
        player?.turnRight()
    }
    
    override func toString() -> String {
        return "\"turn_right\","
    }
    
    override func submit() {
        CommandFactory.WebViewTurnRightCommand().execute()
    }
    
//    override func submitMock() {
//        CommandFactory.WebViewTurnRightCommand().execute()
//        CommandFactory.NativeAddAnimationCommand(TurnRightAnimation()).execute()
//    }
}