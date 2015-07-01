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
    
    struct JSONIdentifier {
        static let Tag = "tag"
        static let Title = "title"
        static let Context = "context"
    }
    
    struct JSONTag {
        static let ResetBlocks = "blocklyReset"
        static let MoveForward = "moveForward"
        static let TurnLeft = "turnLeft"
        static let TurnRight = "turnRight"
        static let Mute = "mute"
        static let OnPlay = "onPlayControls"
        static let OnPause = "onPauseControls"
        static let OnStep = "onStepControls"
        static let OnStop = "onStopControls"
        static let OnResume = "onResumeControls"
        static let PreGameMsg = "preGameMessage"
        static let WinWithNextLevel = "winWithNextLevel"
        static let Fail = "fail"
        static let Help = "help"
    }

    var gameViewController: GameViewController?
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        if let result = message.body as? NSString {
            println(result)
            if let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: data)
                if let tag = json[JSONIdentifier.Tag].string {
                    switch tag {
                        case JSONTag.ResetBlocks:
                            gameViewController!.blockTableViewController!.clearBlocks()
                        case JSONTag.MoveForward:
                            gameViewController!.blockTableViewController!.addBlock(Forward())
                            gameViewController!.gameMapViewController?.skView!.gameScene!.player.moveForward(50, duration: 1)
                        case JSONTag.TurnLeft:
                            gameViewController!.blockTableViewController!.addBlock(Left())
                            gameViewController!.gameMapViewController?.skView!.gameScene!.player.turnLeft(50, duration: 1)
                        case JSONTag.TurnRight:
                            gameViewController!.blockTableViewController!.addBlock(Right())
                            gameViewController!.gameMapViewController?.skView!.gameScene!.player.turnRight(50, duration: 1)
                        case JSONTag.Mute:
                            gameViewController!.gameMenuViewController!.mute = !gameViewController!.gameMenuViewController!.mute
                        case JSONTag.OnPlay:
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onPlayControls
                            gameViewController!.directDriveViewController!.disableDirectDrive()
                        case JSONTag.OnPause:
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onPauseControls
                        case JSONTag.OnStep:
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onStepControls
                        case JSONTag.OnStop:
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onStopControls
                            gameViewController!.directDriveViewController!.enableDirectDrive()
                        case JSONTag.OnResume:
                            gameViewController!.gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onResumeControls
                        case JSONTag.PreGameMsg:
                            if let title = json[JSONIdentifier.Title].string {
                                if let context = json[JSONIdentifier.Context].string {
                                    if let controller = self.gameViewController!.gameMessageViewController {
                                        controller.message = PreGameMessage(title: title, context: context,
                                            action: controller.closeMenu)
                                        controller.toggleMenu()
                                    }
                                }
                            }
                        case JSONTag.WinWithNextLevel:
                            if let title = json[JSONIdentifier.Title].string {
                                if let leadMsg = json["leadMsg"].string {
                                    if let controller = gameViewController!.postGameMessageViewController {
                                        controller.message = PostGameMessage(title: title, context: leadMsg,
                                            nextLevelAction: controller.gotoNextLevelAndDismiss,
                                            playAgainAction: controller.playAgainAndDismiss)
                                        controller.openMenu()
                                    }
                                }
                            }
                        case JSONTag.Fail:
                            if let title = json[JSONIdentifier.Title].string {
                                if let leadMsg = json["leadMsg"].string {
                                    if let controller = gameViewController!.gameMessageViewController {
                                        controller.message = ErrorMessage(title: title, context: leadMsg,
                                            action: controller.closeMenu)
                                        controller.openMenu()
                                    }
                                }
                        }
                        case JSONTag.Help:
                            if let message = json["message"].string {
                                if let controller = gameViewController!.helpViewController {
                                    controller.message = HelpMessage(context: message,
                                        action: controller.closeMenu)
                                    controller.toggleMenu()
                                }
                            }
                        default: break
                    }
                }
            }
        }
    }
    
}
