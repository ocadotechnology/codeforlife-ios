//
//  MessageViewControllerDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 09/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

protocol MessageViewControllerDelegate {
    func gotoNextLevelAndDismiss(completion: (() -> Void)?)
    func playAgainAndDismiss(completion:(() -> Void)?)
}

protocol GameViewInteractionHandlerDelegate {
    /* Requires
        GameViewController
     */
    func executeAnimation(animationQueues: [[Animation]], completion: (() -> Void)?)
}

protocol MapSceneDelegate {
    /* Requires
        GameMenuViewController
        GameMapViewController
     */
    func centerOnNodeDuringAnimation(node: SKNode, completion: (() -> Void)?)
}

protocol GameMenuViewControllerDelegate {
    func setBlocklyEditable(editable: Bool, completion: (() -> Void)?)
    func stop(completion: (() -> Void)?)
    func runAnimation(runAnimation: Bool, completion: (() -> Void)?)
    func stepAnimation(step: Bool, completion: (() -> Void)?)
}