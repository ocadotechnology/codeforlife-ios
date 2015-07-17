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
    
    struct JSONIdentifier {
        static let Tag = "tag"
        static let Title = "title"
        static let Context = "context"
    }
    
    struct JSONTag {
        static let PreGameMsg = "preGameMessage"
        static let PostGameMsg = "postGameMessage"
        static let FailMessage = "failMessage"
        static let HelpMessage = "help"
    }

    weak var gameViewController: GameViewController?
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        if let result = message.body as? NSString {
            if let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: data)
                if let queues = json.array {
                    var animationQueues = [[Animation]]()
                    for queue in queues {
                        var animationQueue = convertToAnimationQueue(queue)
                        animationQueues.append(animationQueue)
                    }
                    
                    for queue in animationQueues {
                        println(queue.count)
                    }
                    
                }
            }
        }
    }
    
    private func convertToAnimationQueue(queue: JSON) -> [Animation] {
        var animations = [Animation]()
        println("___NEW QUEUE___")
        for object in queue {
            if let type = object.1["type"].string {
                println(type)
                var animation: Animation?
                switch type {
                    case "van":
                        animation = convertToVanAnimation(object.1)
                    case "popup":
                        animation = PopUpAnimation()
                    case "trafficlight": break // TODO
                    case "playSound":
                        animation = convertToPlaySoundAnimation(object.1)
                    case "highlight":
                        animation = convertToHighlightAnimation(object.1)
                    case "highlightIncorrect":
                        animation = convertToHighlightIncorrectAnimation(object.1)
                    case "onStopControls":
                        animation = OnStopControlsAnimation()
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
    
    private func convertToVanAnimation(object: JSON) -> Animation? {
        var animation: Animation?
        if let vanAction = object["vanAction"].string {
            switch vanAction {
            case "FORWARD":
                animation = MoveForwardAnimation()
            case "TURN_LEFT":
                animation = TurnLeftAnimation()
            case "TURN_RIGHT":
                animation = TurnRightAnimation()
            case "DELIVER":
                animation = DeliverAnimation()
            case "TURN_AROUND": break // TODO
            default:
                println("Implement van handling for \(description)")
            }
        }
        return animation
    }
    
    private func convertToPlaySoundAnimation(object: JSON) -> Animation? {
        var animation: Animation?
        if let description = object["description"].string {
            switch description {
            case "starting sound":
                animation = MoveForwardAnimation()
            case "starting engine":
                animation = TurnLeftAnimation()
            case "stopping engine":
                animation = TurnRightAnimation()
            case "win sound":
                animation = DeliverAnimation()
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
