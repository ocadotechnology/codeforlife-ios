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

    var gameViewController: GameViewController?
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        if let result = message.body as? NSString {
            if let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: data)
                if let tag = json[JSONIdentifier.Tag].string {
                    println(tag)
                    switch tag {
                    
                    case JSONTag.PreGameMsg:
                        CommandFactory.NativeShowPreGameMessageCommand().execute()
                        
                    case JSONTag.PostGameMsg:
                        if let title = json[JSONIdentifier.Title].string {
                            if let context = json[JSONIdentifier.Context].string {
                                CommandFactory.NativeShowPostGameMessageCommand().execute()
                            }
                        }
                        
                    case JSONTag.FailMessage:
                        if let title = json[JSONIdentifier.Title].string {
                            if let context = json[JSONIdentifier.Context].string {
                                CommandFactory.NativeShowFailMessageCommand().execute()
                            }
                        }
                        
                    case JSONTag.HelpMessage:
                        CommandFactory.NativeHelpCommand().execute()
                        
                        default: break
                    }
                }
            }
        }
    }
    
}
