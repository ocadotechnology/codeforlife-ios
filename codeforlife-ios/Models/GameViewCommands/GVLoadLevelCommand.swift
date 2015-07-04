//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation
import WebKit

class GVLoadLevelCommand : GameViewCommand {

    var level: Level?
    
    init(level: Level, gameViewController: GameViewController) {
        super.init(gameViewController: gameViewController)
        self.level = level
    }
    
    func execute(response:() -> Void = {}) {
        var urlStr = level!.webViewUrl;
        var url = NSURL(string: urlStr);
        
        var request = NSURLRequest(URL: url!);
        gameViewController.webView?.loadRequest(request)
        gameViewController.callBack = response
    }
    
}

