//
//  AnimationDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 07/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

protocol AnimationDelegate {
    
    func highlightCorrectBlock(blockId: Int)
    func highlightIncorrectBLock(blockId: Int)
    func playSound(gameSound: GameSound, waitForCompletion: Bool, completion: (() -> Void)?)
    func deliver(destinationId: Int, completion: (() -> Void)?)
    func vanMoveForward(completion: (() -> Void)?)
    func vanCrashForward(completion: (() -> Void)?)
    func vanStartEngine(completion: (() -> Void)?)
    func vanTurnLeft(completion: (() -> Void)?)
    func vanCrashLeft(completion: (() -> Void)?)
    func vanTurnRight(completion: (() -> Void)?)
    func vanCrashRight(completion: (() -> Void)?)
    func winPopup(message: String, _ pathScore: Float, _ maxPathScore: Int, _ instrScore: Float, _ maxInstrScore: Int, completion: (() -> Void)?)
    func failurePopup(message: String, completion: (() -> Void)?)
    func onStopControls(completion: (() -> Void)?)
    
    func switchControlMode(controlMode: GameMenuViewController.ControlMode, completion: (() -> Void)?)
    func terminateAnimation(completion: (() -> Void)?)
    func resetVan(completion: (() -> Void)?)
}
