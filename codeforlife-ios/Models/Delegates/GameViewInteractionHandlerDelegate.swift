//
//  GameViewInteractionHandlerDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 09/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

protocol GameViewInteractionHandlerDelegate {
    /* Requires
    GameViewController
    */
    func executeAnimation(animationQueues: [[Animation]], completion: (() -> Void)?)
}