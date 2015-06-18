//
//  PlayCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit

class GVJavaScriptCommand : GameViewCommand {
    
    var javascript: String?
    
    init(gameView: WKWebView, javascript: String) {
        super.init(gameView: gameView)
        self.javascript = javascript
    }
    
    override func execute<String>(response: String -> Void) {
        gameView?.evaluateJavaScript(javascript!, completionHandler: { (data, error) -> Void in
        })
    }
    
    
}