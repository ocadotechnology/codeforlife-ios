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
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        if let result = message.body as? NSString {
//            let result2 = "{\"name\":\"Joey\"}"
            if let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: data)
                if let type = json["type"].string {
                    if let content = json["content"].array {
                        switch type {
                            case "changeCurrentTabSelectedToBlockly":
                                gameViewController!.currentTab = gameViewController!.blocklyButton
                            case "changeCurrentTabSelectedToLoad":
                                gameViewController!.currentTab = gameViewController!.loadButton
                            case "changeCurrentTabSelectedToSave":
                                gameViewController!.currentTab = gameViewController!.saveButton
                            case "mute":
                                gameViewController!.mute = !gameViewController!.mute
                            case "onPlayControls":
                                gameViewController!.controlMode = GameViewController.ControlMode.onPlayControls
                            case "onPauseControls":
                                gameViewController!.controlMode = GameViewController.ControlMode.onPauseControls
                            case "onStepControls":
                                gameViewController!.controlMode = GameViewController.ControlMode.onStepControls
                            case "onStopControls":
                                gameViewController!.controlMode = GameViewController.ControlMode.onStopControls
                            case "onResumeControls":
                                gameViewController!.controlMode = GameViewController.ControlMode.onResumeControls
                            case "preGameMessage":
                                TODO()
                            case "postGameMessage":
                                TODO()
                            default: break
                        }
                    }
                }
            }
        }
    }
    
    func executeJavaScript(script: String) {
        gameViewController!.webView!.evaluateJavaScript(script, completionHandler: nil)
    }
    
    private func TODO() {
        fatalError("TODO")
    }
    
}
