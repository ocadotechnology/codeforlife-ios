//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation
import WebKit

class WebViewLoadLevelCommand : LoadLevelCommand {
    var webView: WKWebView

    init(levelNumber: Int, webView: WKWebView) {
        self.webView = webView
        super.init(levelNumber: levelNumber)
    }

    override func excute<Level>(response: Level -> Void) {
        var urlStr = webView.URL!.absoluteString
        urlStr = urlStr?.stringByReplacingOccurrencesOfString(webView.URL!.relativePath!, withString: "")
        urlStr = urlStr! + "/rapidrouter/\(level.number)";
        var url = NSURL(string: urlStr!);
        
        var request = NSURLRequest(URL: url!);
        webView.loadRequest(request)

        response(level as! Level)
    }
}

