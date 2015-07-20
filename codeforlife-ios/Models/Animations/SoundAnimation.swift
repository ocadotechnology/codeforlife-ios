//
//  StartingSoundAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

enum GameSound: String {
    case Starting = "starting.mp3"
    case Delivery = "delivery.mp3"
    case Win = "win.mp3"
    case Failure = "failure.mp3"
    case Tension = "tension.mp3"
    case Crash = "crash.mp3"
}

class SoundAnimation: Animation {
    
    let gameSound: GameSound
    
    init(gameSound: GameSound) {
        self.gameSound = gameSound
    }
    
    override func executeAnimation(completion: (() -> Void)? = nil) {
        SharedContext.MainGameViewController?.gameMapViewController?.map?.player.runAction(SKAction.playSoundFileNamed(gameSound.rawValue, waitForCompletion: true)) {
            completion?()
        }
        
    }
}