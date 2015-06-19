//
//  GVSaveCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit

class GVSaveCommand : GVJavaScriptCommand {
    
    init(gameView: WKWebView) {
        super.init(gameView: gameView, javascript: kC4LGameViewSaveCommandJavaScript)
    }
    
}