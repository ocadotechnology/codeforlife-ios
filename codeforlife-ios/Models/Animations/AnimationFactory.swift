//
//  AnimationFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 23/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SwiftyJSON
import Foundation

class AnimationFactory {
    
    final func createAnimation(json: JSON) -> Animation? {
        var animation: Animation?
        if let type = json["type"].string {
            switch type {
            case "van":
                animation = convertToVanAnimation(json)
            case "popup":
                animation = convertToPopupAnimation(json)
            case "playSound":
                animation = convertToPlaySoundAnimation(json)
            case "highlight":
                animation = convertToHighlightAnimation(json)
            case "highlightIncorrect":
                animation = convertToHighlightIncorrectAnimation(json)
            case "onStopControls":
                animation = OnStopControlsAnimation()
            case "trafficlight": break // TODO
            default: break
            }
        }
        return animation
    }
    
    private func convertToPopupAnimation(json: JSON) -> Animation? {
        var animation: Animation?
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
                        
                        animation = WinPopupAnimation(
                            message: processedMessage,
                            pathScore: pathLengthScore,
                            maxPathScore: maxScoreForPathLength,
                            instrScore: instrScore,
                            maxInstrScore: maxScoreForNumberOfInstructions)
                }
            case "FAIL":
                if let popupMessage = json["popupMessage"].string {
                    animation = FailurePopupAnimation(message: popupMessage)
                }
            default: break
            }
        }
        return animation
    }
    
    private func convertToVanAnimation(json: JSON) -> Animation? {
        var animation: Animation?
        if let player = SharedContext.MainGameViewController?.gameMapViewController?.map?.van,
            vanAction = json["vanAction"].string {
                switch vanAction {
                case "FORWARD":
                    animation = MoveForwardAnimation()
                case "TURN_LEFT":
                    animation = TurnLeftAnimation()
                case "TURN_RIGHT":
                    animation = TurnRightAnimation()
                case "DELIVER":
                    if let destinationId = json["destinationID"].int {
                        animation = DeliverAnimation(destinationId: destinationId)
                    }
                case "CRASH":
                    animation = convertToCrashAnimation(json)
                case "TURN_AROUND": break // TODO
                default:
                    println("Implement van handling for \(vanAction)")
                }
        }
        return animation
    }
    
    private func convertToCrashAnimation(json: JSON) -> Animation? {
        var animation: Animation?
        if let player = SharedContext.MainGameViewController?.gameMapViewController?.map?.van,
            attemptedAction = json["attemptedAction"].string {
                switch attemptedAction {
                case "FORWARD":
                    animation = MoveForwardCrashAnimation()
                case "TURN_LEFT":
                    animation = TurnLeftCrashAnimation()
                case "TURN_RIGHT":
                    animation = TurnRightCrashAnimation()
                default: break
                }
        }
        return animation
    }
    
    private func convertToPlaySoundAnimation(json: JSON) -> Animation? {
        var animation: Animation?
        if let description = json["description"].string {
            switch description {
            case "starting sound":
                animation = SoundAnimation(gameSound: GameSound.Starting)
            case "starting engine":
                animation = StartEngineAnimation()
            case "stopping engine":
                animation = StopEngineAnimation()
            case "win sound":
                animation = SoundAnimation(gameSound: GameSound.Win)
            case "failure sound":
                animation = SoundAnimation(gameSound: GameSound.Failure)
            case "crash sound":
                animation = SoundAnimation(gameSound: GameSound.Crash)
            case "delivery":
                animation = SoundAnimation(gameSound: GameSound.Delivery)
            default:
                println("Implement sound handling for \(description)")
            }
        }
        return animation
    }
    
    private func convertToHighlightAnimation(json: JSON) -> Animation? {
        var animation: Animation?
        if let blockId = json["blockId"].int {
            animation = HighlightAnimation(blockId: blockId)
        }
        return animation
    }
    
    private func convertToHighlightIncorrectAnimation(json: JSON) -> Animation? {
        var animation: Animation?
        if let blockId = json["blockId"].int {
            animation = HighlightIncorrectAnimation(blockId: blockId)
        }
        return animation
    }
    
    
}
