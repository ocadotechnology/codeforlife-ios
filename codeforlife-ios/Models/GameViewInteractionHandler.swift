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
                            case "changeCurrentTabToBlockly":
                                gameViewController?.currentTab = gameViewController?.blocklyButton
                            case "changeCurrentTabToLoad":
                                gameViewController?.currentTab = gameViewController?.loadButton
                            case "changeCurrentTabToSave":
                                gameViewController?.currentTab = gameViewController?.saveButton
                            case "mute":
                                gameViewController?.mute = true
                            case "unmute":
                                gameViewController?.mute = false
                            case "isPlaying":
                                TODO(content)
                            case "isPaused":
                                TODO(content)
                            case "isStopped":
                                TODO(content)
                            case "isFinished":
                                TODO(content)
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
    
    func askForCurrentTab() {
        executeJavaScript(
            "var result = ocargo.game.currentTabSelected;" +
            "window.webkit.messageHandlers.handler.postMessage(\"{'name':'joey'}\")"
        )
    }
    
    func TODO(content: [JSON]) {
        fatalError("TODO")
    }
    
    
}
