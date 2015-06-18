//
//  GameViewCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit

class GameViewCommand : Command {
    
    var gameView: WKWebView?
    
    init(gameView: WKWebView) {
        self.gameView = gameView
    }
    
    func execute<T>(response: T -> Void) {
        NSException(name: "Absract GameViewCommand method called", reason: "" , userInfo: nil).raise()
    }
    
}
