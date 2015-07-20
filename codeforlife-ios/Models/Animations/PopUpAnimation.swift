//
//  PopUpAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class PopUpAnimation: Animation {
    
    var popupMessage: String
    
    init(message: String) {
        self.popupMessage = message
    }
    
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Popup")
        completion?()
    }
}

class WinPopupAnimation: PopUpAnimation {
    
    var pathScore: Float
    var instrScore: Float
    var maxPathScore: Int
    var maxInstrScore: Int
    
    init(message: String, pathScore: Float, maxPathScore: Int, instrScore: Float, maxInstrScore: Int) {
        self.pathScore = pathScore
        self.instrScore = instrScore
        self.maxPathScore = maxPathScore
        self.maxInstrScore = maxInstrScore
        super.init(message: message)
    }
    
    override func executeAnimation(#completion: (() -> Void)?) {
        println("Win Popup")
        let controller = MessageViewController.MessageViewControllerInstance()
        controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        SharedContext.MainGameViewController?.presentViewController(controller, animated: true, completion: nil)
        controller.message = PostGameMessage(
            context: popupMessage,
            pathScore: pathScore,
            maxPathScore: maxPathScore,
            instrScore: instrScore,
            maxInstrScore: maxInstrScore,
            nextLevelAction: {
                controller.gotoNextLevelAndDismiss()
                controller.dismissViewControllerAnimated(true, completion: nil)
            },
            playAgainAction: {
                controller.playAgainAndDismiss()
                controller.dismissViewControllerAnimated(true, completion: nil)
        })
        completion?()
    }
}

class FailurePopupAnimation: PopUpAnimation {
    override func executeAnimation(#completion: (() -> Void)?) {
        println("Failuer Popup")
        let controller = MessageViewController.MessageViewControllerInstance()
        controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        SharedContext.MainGameViewController?.presentViewController(controller, animated: true, completion: nil)
        controller.message = FailMessage(
            title: "Oh dear!",
            context: popupMessage,
            action: {
                controller.dismissViewControllerAnimated(true, completion: nil)
        })
        completion?()
    }
}