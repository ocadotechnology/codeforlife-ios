//
//  GameViewInteractionHandler.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 22/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import WebKit

// Deprecated
class GameViewInteractionHandler: NSObject, WKScriptMessageHandler {

    weak var gameViewController: GameViewController?
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        if let result = message.body as? NSString {
            println(result)
            if let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: data)
                if let queues = json.array {
                    var animationQueues = [[Animation]]()
                    for queue in queues {
                        var animationQueue = convertToAnimationQueue(queue)
                        animationQueues.append(animationQueue)
                    }
                    SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.animationQueues = animationQueues
                    SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.currentIndex = 0
                    SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.runAnimation = true
                }
            }
        }
    }
    
    private func convertToAnimationQueue(queue: JSON) -> [Animation] {
        var animations = [Animation]()
        println("___NEW QUEUE___")
        for object in queue {
            if let type = object.1["type"].string {
                println((type, object.1["description"]))
                var animation: Animation?
                switch type {
                    case "van":
                        animation = convertToVanAnimation(object.1)
                    case "popup":
                        animation = convertToPopupAnimation(object.1)
                    case "playSound":
                        animation = convertToPlaySoundAnimation(object.1)
                    case "highlight":
                        animation = convertToHighlightAnimation(object.1)
                    case "highlightIncorrect":
                        animation = convertToHighlightIncorrectAnimation(object.1)
                    case "onStopControls":
                        animation = OnStopControlsAnimation()
                    case "trafficlight": break // TODO
                default: break
                }
                if animation != nil {
                    animations.append(animation!)
                }
            }
        }
        println("")
        return animations
    }
    
    private func convertToPopupAnimation(object: JSON) -> Animation? {
        var animation: Animation?
        if let popupType = object["popupType"].string {
            switch popupType {
                case "WIN":
                    if let popupMessage = object["popupMessage"].string,
                            pathLengthScore = object["pathLengthScore"].float,
                            maxScoreForPathLength = object["maxScoreForPathLength"].int,
                            instrScore = object["instrScore"].float,
                            maxScoreForNumberOfInstructions = object["maxScoreForNumberOfInstructions"].int {
                        animation = WinPopupAnimation(
                            message: popupMessage,
                            pathScore: pathLengthScore,
                            maxPathScore: maxScoreForPathLength,
                            instrScore: instrScore,
                            maxInstrScore: maxScoreForNumberOfInstructions)
                    }
                case "FAIL":
                    if let popupMessage = object["popupMessage"].string {
                        animation = FailurePopupAnimation(message: popupMessage)
                    }
            default: break
            }
        }
        return animation
    }
    
    private func convertToVanAnimation(object: JSON) -> Animation? {
        var animation: Animation?
        if let player = SharedContext.MainGameViewController?.gameMapViewController?.map?.player,
                vanAction = object["vanAction"].string {
            switch vanAction {
            case "FORWARD":
                animation = MoveForwardAnimation(object: player)
            case "TURN_LEFT":
                animation = TurnLeftAnimation(object: player)
            case "TURN_RIGHT":
                animation = TurnRightAnimation(object: player)
            case "DELIVER":
                if let destinationId = object["destinationID"].int {
                    animation = DeliverAnimation(destinationId: destinationId)
                }
            case "CRASH":
                animation = convertToCrashAnimation(object)
            case "TURN_AROUND": break // TODO
            default:
                println("Implement van handling for \(description)")
            }
        }
        return animation
    }
    
    private func convertToCrashAnimation(object: JSON) -> Animation? {
        var animation: Animation?
        if let player = SharedContext.MainGameViewController?.gameMapViewController?.map?.player,
                attemptedAction = object["attemptedAction"].string {
            switch attemptedAction {
                case "FORWARD":
                    animation = MoveForwardAnimation(object: player)
                case "TURN_LEFT":
                    animation = TurnLeftAnimation(object: player)
                case "TURN_RIGHT":
                    animation = TurnRightAnimation(object: player)
            default: break
            }
        }
        return animation
    }
    
    private func convertToPlaySoundAnimation(object: JSON) -> Animation? {
        var animation: Animation?
        if let description = object["description"].string {
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
    
    private func convertToHighlightAnimation(object: JSON) -> Animation? {
        var animation: Animation?
        if let blockId = object["blockId"].int {
            animation = HighlightAnimation(blockId: blockId)
        }
        return animation
    }
    
    private func convertToHighlightIncorrectAnimation(object: JSON) -> Animation? {
        var animation: Animation?
        if let blockId = object["blockId"].int {
            animation = HighlightIncorrectAnimation(blockId: blockId)
        }
        return animation
    }
    
}
