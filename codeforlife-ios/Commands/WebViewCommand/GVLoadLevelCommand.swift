//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation
import WebKit

class GVLoadLevelCommand : LoadLevelCommand {
    
    var webView: WKWebView?

    init(level: Level, webView: WKWebView) {
        super.init(level: level)
        self.webView = webView
    }

    override func execute<Level>(response: Level -> Void) {
        var urlStr = kCFLDomain + kCFLRapidRouter + "\(level.number!)";
        println(urlStr)
        var url = NSURL(string: urlStr);
        
        var request = NSURLRequest(URL: url!);
        webView!.loadRequest(request)
    }
}

