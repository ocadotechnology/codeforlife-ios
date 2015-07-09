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
    
    init(gameViewController: GameViewController, javascript: String) {
        super.init(gameViewController: gameViewController)
        self.javascript = javascript
    }
    
    override func executeWithCompletionHandler(completion:() -> Void) {
        
        gameViewController.runJavaScript(javascript!) {
            completion()
        }
    }
    
    
}