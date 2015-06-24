//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation
import WebKit

class GVLoadLevelCommand : GameViewCommand {

    var level: Level?
    
    init(level: Level, gameView: WKWebView) {
        super.init(gameView: gameView)
        self.level = level
    }
    
    override func execute<Level> (response: Level -> Void) {
        var urlStr = kCFLDomain + kCFLRapidRouter + "\(level!.number!)";
        var url = NSURL(string: urlStr);
        
        var request = NSURLRequest(URL: url!);
        gameView!.loadRequest(request)
    }
    
}

