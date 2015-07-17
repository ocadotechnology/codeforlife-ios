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
                        var animationQueue = [Animation]()
                        for animation in queue {
                            if let description = animation.1["description"].string {
                                switch description {
                                    case "starting sound":
                                        animationQueue.append(SoundAnimation(gameSound: GameSound.Starting))
                                    case "starting engine":
                                        animationQueue.append(StartEngineAnimation())
                                    case "van move action: FORWARD":
                                        animationQueue.append(MoveForwardAnimation())
                                    case "van delivering":
                                        animationQueue.append(DeliverAnimation())
                                    case "stopping engine":
                                        animationQueue.append(StopEngineAnimation())
                                    case "win popup":
                                        animationQueue.append(PopUpAnimation())
                                    case "win sound":
                                        animationQueue.append(SoundAnimation(gameSound: GameSound.Win))
                                    case "onStopControls":
                                        animationQueue.append(OnStopControlsAnimation())
                                default:
                                    println("Implement Handling for \(description)")
                                }
                            }
                        }
                        animationQueues.append(animationQueue)
                    }
                    
                    for queue in animationQueues {
                        println(queue.count)
                    }
                    
                }
            }
        }
    }
    
}
