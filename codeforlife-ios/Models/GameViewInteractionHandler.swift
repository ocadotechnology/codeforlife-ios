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
    
    static let command = "window.webkit.messageHandlers.handler.postMessage(result)"

    var gameViewController: GameViewController?
    var gameMenuViewController: GameMenuViewController?
    var blockTableViewController: BlockTableViewController?
    var directDriveViewController: DirectDriveViewController?
    
    override init() {
        super.init()
    }
    
    private func checkControllers() {
        if gameViewController == nil {
            fatalError("GameViewController is nil")
        } else if gameMenuViewController == nil {
            fatalError("GameMenuViewController is nil")
        } else if blockTableViewController == nil {
            fatalError("BlockTableViewController is nil")
        } else if directDriveViewController == nil {
            fatalError("DirectDriveViewController is nil")
        }
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        checkControllers()
        if let result = message.body as? NSString {
            if let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: data)
                if let type = json["type"].string {
                    if let content = json["content"].array {
                        switch type {
                            case "mute":
                                gameMenuViewController!.mute = !gameMenuViewController!.mute
                            case "onPlayControls":
                                gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onPlayControls
                            case "onPauseControls":
                                gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onPauseControls
                            case "onStepControls":
                                gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onStepControls
                            case "onStopControls":
                                gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onStopControls
                            case "onResumeControls":
                                gameMenuViewController!.controlMode = GameMenuViewController.ControlMode.onResumeControls
                            case "preGameMessage":
                                TODO()
                            case "postGameMessage":
                                TODO()
                            case "clearBlocks":
                                blockTableViewController!.clearBlocks()
                            default: break
                        }
                    }
                }
            }
        }
    }
    
//    func executeJavaScript(script: String) {
//        gameViewController!.webView!.evaluateJavaScript(script, completionHandler: nil)
//    }
    
    private func TODO() {
        fatalError("TODO")
    }
    
}
