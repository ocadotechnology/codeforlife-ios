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

class GameViewInteractionHandler: NSObject, WKScriptMessageHandler {

    var gameViewController: GameViewController?
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        if let result = message.body as? NSString {
            println(result)
            if let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: data)
                if let tag = json["tag"].string {
                    switch tag {
                        case "blocklyReset":
                            gameViewController!.blockTableViewController!.clearBlocks()
                        case "moveForward":
                            gameViewController!.blockTableViewController!.addBlock(Forward())
                        case "turnLeft":
                            gameViewController!.blockTableViewController!.addBlock(Left())
                        case "turnRight":
                            gameViewController!.blockTableViewController!.addBlock(Right())
                        case "mute":
                            gameViewController!.gameMenuViewController!.mute = !gameViewController!.gameMenuViewController!.mute
                        case "onPlayControls":
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onPlayControls
                        case "onPauseControls":
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onPauseControls
                        case "onStepControls":
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onStepControls
                        case "onStopControls":
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onStopControls
                        case "onResumeControls":
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onResumeControls
                        case "preGameMessage":
                            if let title = json["title"].string {
                                if let context = json["context"].string {
                                    if let button = json["buttons"].string {
                                        if let controller = self.gameViewController!.gameMessageViewController {
                                            controller.message = PreGameMessage(title: title, context: context, button: button) {
                                                controller.open = false
                                            }
                                            controller.open = !controller.open
                                        }
                                    }
                                }
                            }
                        case "winWithNextLevel":
                            if let title = json["title"].string {
                                if let leadMsg = json["leadMsg"].string {
                                    if let button = json["buttons"].string {
                                        if let controller = gameViewController!.postGameMessageViewController {
                                            controller.message = PostGameMessage(title: title, context: leadMsg, button: button,
                                                nextLevelAction: {
                                                    if let gameViewController = self.gameViewController {
                                                        if let nextLevel = gameViewController.level?.nextLevel {
                                                            gameViewController.level = nextLevel
                                                        }
                                                    }
                                                    controller.open = false
                                                },
                                                playAgainAction: {
                                                    self.gameViewController!.level = self.gameViewController!.level
                                                    controller.open = false
                                                })
                                            controller.open = true
                                        }
                                    }
                                }
                            }
                        case "fail":
                            if let title = json["title"].string {
                                if let leadMsg = json["leadMsg"].string {
                                    if let button = json["buttons"].string {
                                        if let controller = gameViewController!.gameMessageViewController {
                                            controller.message = ErrorMessage(title: title, context: leadMsg, button: button) {
                                                controller.open = false
                                            }
                                            controller.open = true
                                        }
                                    }
                                }
                        }
                        case "help":
                            if let message = json["message"].string {
                                if let controller = gameViewController!.helpViewController {
                                    controller.message = HelpMessage {
                                        controller.open = false
                                    }
                                    controller.open = true
                                }
                            }
                        default: break
                    }
                }
            }
        }
    }
    
    private func TODO() {
        fatalError("TODO")
    }
    
}
