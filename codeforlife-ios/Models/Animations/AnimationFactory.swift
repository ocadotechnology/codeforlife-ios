//
//  AnimationFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 08/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON

public class AnimationFactory {
    
    weak var animationDelegate: GameViewControllerDelegate?
    
    init(animationDelegate: GameViewControllerDelegate?) {
        self.animationDelegate = animationDelegate
    }

    func createAction(json: JSON) -> Animation? {
        var action: Animation?
        if let type = json["type"].string {
            switch type {
            case "van":                 action = convertToVanAction(json)
            case "popup":               action = convertToPopupAction(json)
            case "playSound":           action = convertToPlaySoundAction(json)
            case "highlight":           action = convertToHighlightAction(json)
            case "highlightIncorrect":  action = convertToHighlightIncorrectAction(json)
            case "onStopControls":      action = OnStopControlsAction(delegate: animationDelegate)
                
            default: break
            }
        }
        return action
    }
    
    private func convertToPopupAction(json: JSON) -> Animation? {
        var action: Animation?
        if let popupType = json["popupType"].string {
            switch popupType {
            case "WIN":
                if let popupMessage = json["popupMessage"].string,
                    pathLengthScore = json["pathLengthScore"].float,
                    maxScoreForPathLength = json["maxScoreForPathLength"].int,
                    instrScore = json["instrScore"].float,
                    maxScoreForNumberOfInstructions = json["maxScoreForNumberOfInstructions"].int {
                        
                        var processedMessage = popupMessage
                            .stringByReplacingOccurrencesOfString("<br>", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            .stringByReplacingOccurrencesOfString("<b>", withString: "<", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            .stringByReplacingOccurrencesOfString("</b>", withString: ">", options: NSStringCompareOptions.LiteralSearch, range: nil)
                        
                        action = WinPopupAction(
                            delegate: animationDelegate,
                            message: processedMessage,
                            pathScore: pathLengthScore,
                            maxPathScore: maxScoreForPathLength,
                            instrScore: instrScore,
                            maxInstrScore: maxScoreForNumberOfInstructions)
                }
            case "FAIL":
                if let popupMessage = json["popupMessage"].string {
                    action = FailurePopupAction(message: popupMessage, delegate: animationDelegate)
                }
            default: break
            }
        }
        return action
    }
    
    private func convertToVanAction(json: JSON) -> Animation? {
        var action: Animation?
        if let vanAction = json["vanAction"].string {
                switch vanAction {
                case "FORWARD":
                    action = GameVanMoveForwardAction(delegate: animationDelegate)
                case "TURN_LEFT":
                    action = GameVanTurnLeftAction(delegate: animationDelegate)
                case "TURN_RIGHT":
                    action = GameVanTurnRightAction(delegate: animationDelegate)
                case "DELIVER":
                    if let destinationId = json["destinationID"].int {
                        action = GameVanDeliverAction(delegate: animationDelegate, destinationId: destinationId)
                    }
                case "CRASH":
                    action = convertToCrashAction(json)
                    
                default: print("Implement van handling for \(vanAction)")
                }
        }
        return action
    }
    
    private func convertToCrashAction(json: JSON) -> Animation? {
        var animation: Animation?
        if let attemptedAction = json["attemptedAction"].string {
                switch attemptedAction {
                case "FORWARD":
                    animation = GameVanMoveForwardCrashAction(delegate: animationDelegate)
                case "TURN_LEFT":
                    animation = GameVanTurnLeftCrashAction(delegate: animationDelegate)
                case "TURN_RIGHT":
                    animation = GameVanTurnRightCrashAction(delegate: animationDelegate)
                    
                default: break
                }
        }
        return animation
    }
    
    private func convertToPlaySoundAction(json: JSON) -> Animation? {
        var action: Animation?
        if let description = json["description"].string {
            switch description {
            case "starting sound":
                action = GameSoundAction(delegate: animationDelegate, gameSound: GameSound.Starting, waitForCompletion: true)
            case "starting engine":
                action = GameVanStartEngineAction(delegate: animationDelegate)
            case "stopping engine":
                action = GameVanStopEngineAction(delegate: animationDelegate)
            case "win sound":
                action = GameSoundAction(delegate: animationDelegate, gameSound: GameSound.Win, waitForCompletion: false)
            case "failure sound":
                action = GameSoundAction(delegate: animationDelegate, gameSound: GameSound.Failure, waitForCompletion: false)
            case "crash sound":
                action = GameSoundAction(delegate: animationDelegate, gameSound: GameSound.Crash, waitForCompletion: false)
            case "delivery":
                action = GameSoundAction(delegate: animationDelegate, gameSound: GameSound.Delivery, waitForCompletion: true)
                
            default: print("Implement sound handling for \(description)")
            }
        }
        return action
    }
    
    private func convertToHighlightAction(json: JSON) -> Animation? {
        var action: Animation?
        if let blockId = json["blockId"].int {
            action = BlocklyHighlightAnimation(delegate: animationDelegate, blockId: blockId)
        }
        return action
    }
    
    private func convertToHighlightIncorrectAction(json: JSON) -> Animation? {
        var action: Animation?
        if let blockId = json["blockId"].int {
            action = BlocklyHighlightIncorrectAction(delegate: animationDelegate, blockId: blockId)
        }
        return action
    }
    
}
