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

    override func execute<Int>(response: Int -> Void) {
        gameView?.evaluateJavaScript(javascript!) { (data, error) -> Void in
        }
    }
    
    func execute(response:() -> Void = {} ) {
        gameView?.evaluateJavaScript(javascript!) { (data, error) -> Void in
            response()
        }
    }
    
    
}