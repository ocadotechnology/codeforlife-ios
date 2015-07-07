//
//  GameMenuCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class GameMenuCommand: GameViewCommand {}

class NGVHelpCommand : GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        if let controller = gameViewController.gameMenuViewController.delegate.controller {
            controller.closeMenu()
            gameViewController.gameMenuViewController.delegate.controller = nil
        } else {
            let controller = MessageViewController.MessageViewControllerInstance()
            gameViewController.addChildViewController(controller)
            gameViewController.view.addSubview(controller.view)
            controller.didMoveToParentViewController(gameViewController)
            controller.message = HelpMessage(
                context: gameViewController.level!.hint!,
                action: {
                    controller.closeMenu()
                    self.gameViewController.gameMenuViewController.delegate.controller = nil
                    controller.willMoveToParentViewController(nil)
            })
            gameViewController.gameMenuViewController.delegate.controller = controller
            controller.toggleMenu()
        }
        completion()
    }
}

class NGVClearCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.blockTableViewController.clearBlocks()
        gameViewController.gameMapViewController.map?.player.resetPosition()
        completion()
    }
}

class NGVPlayCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController.map?.player.resetPosition()
        gameViewController.blockTableViewController.blocks.first?.executeBlockChainAction(gameViewController.gameMapViewController.map!.player)
        completion()
    }
}

class NGVMuteCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMenuViewController.mute = !gameViewController.gameMenuViewController.mute
    }
}
