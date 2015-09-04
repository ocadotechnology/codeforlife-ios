//
//  GameSoundAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

enum GameSound: String {
    case Starting   = "starting.mp3"
    case Delivery   = "delivery.mp3"
    case Win        = "win.mp3"
    case Failure    = "failure.mp3"
    case Tension    = "tension.mp3"
    case Crash      = "crash.mp3"
}

class GameSoundAction: Animation {
    
    let gameSound: GameSound
    let waitForCompletion: Bool
    
    init(delegate: GameViewControllerDelegate?, gameSound: GameSound, waitForCompletion: Bool) {
        self.gameSound = gameSound
        self.waitForCompletion = waitForCompletion
        super.init(delegate: delegate)
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        println("Play Game Sound: \(gameSound.rawValue)")
        delegate?.playSound(gameSound, waitForCompletion: waitForCompletion, completion: completion)
    }
}