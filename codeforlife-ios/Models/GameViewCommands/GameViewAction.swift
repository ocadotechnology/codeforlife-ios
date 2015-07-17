//
//  GameViewAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit

class GameViewAction: Action {
    
    weak var gameViewController: GameViewController? {
        return SharedContext.MainGameViewController
    }
    
}

class WebViewLoadLevelAction : GameViewAction {
    
    override func execute(completion: (() -> Void)? = nil) {
        if let urlStr = gameViewController?.level?.webViewUrl {
            var url = NSURL(string: urlStr);
            var request = NSURLRequest(URL: url!);
            gameViewController?.webView?.loadRequest(request)
        }
    }
    
}

class NGVShowPreGameMessageAction: GameViewAction {
    override func execute(completion: (() -> Void)? = nil) {
        let controller = MessageViewController()
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        gameViewController?.presentViewController(controller, animated: true, completion: nil)
        if let level = gameViewController?.level {
            controller.message = PreGameMessage(
                title: "Level \(level.name)",
                context: level.description!,
                action: {
                    controller.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        gameViewController?.activityIndicator?.stopAnimating()
        completion?()
    }
}

class GVJavaScriptAction : GameViewAction {
    
    var javascript: String?
    
    init(gameViewController: GameViewController, javascript: String) {
        self.javascript = javascript
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController?.runJavaScript(javascript!) {
            completion?()
        }
    }
    
}


