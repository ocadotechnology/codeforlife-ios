//
//  GameMenuCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class GameMenuCommand: GameViewCommand {}

class NGVShowHelpCommand : GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        let controller = MessageViewController.MessageViewControllerInstance()
        gameViewController.addChildViewController(controller)
        gameViewController.view.addSubview(controller.view)
        controller.didMoveToParentViewController(gameViewController)
        controller.message = HelpMessage(
            context: gameViewController.level!.hint!,
            action: {
                controller.closeMenu()
                self.gameViewController.gameMenuViewController?.delegate.controller = nil
                controller.willMoveToParentViewController(nil)
                controller.view.removeFromSuperview()
                controller.removeFromParentViewController()
        })
        gameViewController.gameMenuViewController?.delegate.controller = controller
        controller.toggleMenu()
        completion()
    }
}

class NGVClearCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.blockTableViewController?.clearBlocks()
        gameViewController.gameMapViewController?.map?.player.resetPosition()
        completion()
    }
}


class NGVMuteCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMenuViewController?.mute = !gameViewController.gameMenuViewController!.mute
        completion()
    }
}

class NGVPlayCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        CommandFactory.WebViewClearCommand().execute()
        gameViewController.gameMenuViewController?.clearButton.enabled = false
        gameViewController.gameMapViewController?.map?.player.resetPosition()
        gameViewController.blockTableViewController?.selectedBlock = 0
        gameViewController.blockTableViewController?.submitBlocks()
        CommandFactory.WebViewPlayCommand().execute()
        gameViewController.gameMenuViewController?.controlMode = .onStopControls
//        gameViewController.blockTableViewController.blocks.first?
//            .executeBlockChainAction(gameViewController.gameMapViewController.map!.player)
        completion()
    }
}

class NGVPauseCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.pause()
        completion()
    }
}

class NGVResumeCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.unpause()
        completion()
    }
}

class NGVStopCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMenuViewController?.clearButton.enabled = true
        completion()
    }
}

class NGVSwitchControlMode: GameMenuCommand {
    
    var controlMode: GameMenuViewController.ControlMode
    
    init(gameViewController: GameViewController, controlMode: GameMenuViewController.ControlMode) {
        self.controlMode = controlMode
        super.init(gameViewController: gameViewController)
    }
    
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMenuViewController?.controlMode = self.controlMode
    }
}

