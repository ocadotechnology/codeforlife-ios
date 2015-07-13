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
    
    unowned var gameViewController: GameViewController
    
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
    
    weak var level: Level?
    
    init(level: Level, gameViewController: GameViewController) {
        super.init(gameViewController: gameViewController)
        self.level = level
    }
    
    override func executeWithCompletionHandler(completion:() -> Void) {
        var urlStr = level!.webViewUrl;
        var url = NSURL(string: urlStr);
        
        var request = NSURLRequest(URL: url!);
        gameViewController.webView?.loadRequest(request)
        gameViewController.callBack = completion
    }
    
}

class NGVShowPreGameMessageCommand: GameViewCommand {
    override func executeWithCompletionHandler(completion:() -> Void) {
        let controller = MessageViewController.MessageViewControllerInstance()
        gameViewController.addChildViewController(controller)
        gameViewController.view.addSubview(controller.view)
        controller.didMoveToParentViewController(gameViewController)
        if let level = gameViewController.level {
            controller.message = PreGameMessage(title: "Level \(level.name)", context: level.description!,
                action: {
                    controller.closeMenu()
                    controller.willMoveToParentViewController(nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParentViewController()
            })
            controller.toggleMenu()
        }
        gameViewController.activityIndicator?.stopAnimating()
        completion()
    }
}

class NGVShowPostGameMessageCommand: GameViewCommand {
    override func executeWithCompletionHandler(completion:() -> Void) {
        let controller = MessageViewController.MessageViewControllerInstance()
        gameViewController.addChildViewController(controller)
        gameViewController.view.addSubview(controller.view)
        controller.didMoveToParentViewController(gameViewController)
        if let level = gameViewController.level {
            controller.message = PostGameMessage(
                title: "TODO",
                context: "TODO",
                nextLevelAction: {
                    controller.gotoNextLevelAndDismiss()
                    controller.willMoveToParentViewController(nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParentViewController()
                },
                playAgainAction: {
                    controller.playAgainAndDismiss()
                    controller.willMoveToParentViewController(nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParentViewController()
                })
            controller.toggleMenu()
        }
        completion()
    }
}

class NGVShowFailMessageCommand: GameViewCommand {
    override func executeWithCompletionHandler(completion:() -> Void) {
        let controller = MessageViewController.MessageViewControllerInstance()
        gameViewController.addChildViewController(controller)
        gameViewController.view.addSubview(controller.view)
        controller.didMoveToParentViewController(gameViewController)
        if let level = gameViewController.level {
            controller.message = FailMessage(
                title: "FAIL",
                context: "Errrrr... I haven't connected this to the API",
                action: {
                    controller.closeMenu()
                    controller.willMoveToParentViewController(nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParentViewController()
            })
            controller.toggleMenu()
            gameViewController.gameMenuViewController?.controlMode = .onStopControls
        }
        completion()
    }
}


