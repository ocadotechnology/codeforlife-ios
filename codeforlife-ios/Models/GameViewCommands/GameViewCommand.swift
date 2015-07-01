//
//  GameViewCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit

protocol Command {
    func execute()
    func executeWithCompletionHandler(completion: () -> Void)
}

class GameViewCommand : Command {
    
    var gameViewController: GameViewController
    
    init(gameViewController: GameViewController ) {
        self.gameViewController = gameViewController
    }
    
    func execute() {
        executeWithCompletionHandler{}
    }
    
    func executeWithCompletionHandler(completion: () -> Void) {
        completion()
        fatalError("Abstract GameViewCommand method called")
    }

}

class GVLoadLevelCommand : GameViewCommand {
    
    var level: Level?
    
    init(level: Level, gameViewController: GameViewController) {
        super.init(gameViewController: gameViewController)
        self.level = level
    }
    
    override func executeWithCompletionHandler(response:() -> Void) {
        var urlStr = level!.webViewUrl;
        var url = NSURL(string: urlStr);
        
        var request = NSURLRequest(URL: url!);
        gameViewController.webView?.loadRequest(request)
        gameViewController.callBack = response
    }
    
}


