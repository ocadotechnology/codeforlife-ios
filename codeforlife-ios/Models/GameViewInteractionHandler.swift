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
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    init(gameMenuViewController: GameMenuViewController) {
        self.gameMenuViewController = gameMenuViewController
    }
    
    init(gameViewController: GameViewController, gameMenuViewController: GameMenuViewController) {
        self.gameViewController = gameViewController
        self.gameMenuViewController = gameMenuViewController
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        if let result = message.body as? NSString {
//            let result2 = "{\"name\":\"Joey\"}"
            if let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: data)
                if let type = json["type"].string {
                    if let content = json["content"].array {
                        switch type {
//                            case "changeCurrentTabSelectedToBlockly":
//                                gameMenuViewController!.currentTab = gameMenuViewController!.blocklyButton
//                            case "changeCurrentTabSelectedToLoad":
//                                gameMenuViewController!.currentTab = gameMenuViewController!.loadButton
//                            case "changeCurrentTabSelectedToSave":
//                                gameMenuViewController!.currentTab = gameMenuViewController!.saveButton
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
