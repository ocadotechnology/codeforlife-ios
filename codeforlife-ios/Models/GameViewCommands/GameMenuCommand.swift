//
//  GameMenuCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class GameMenuCommand: GameViewCommand {
    weak var viewController: GameMenuViewController? {
        return gameViewController.gameMenuViewController
    }
}

class NGVShowHelpCommand : GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        let controller = MessageViewController.MessageViewControllerInstance()
        gameViewController.addChildViewController(controller)
        gameViewController.view.addSubview(controller.view)
        controller.didMoveToParentViewController(gameViewController)
        controller.message = HelpMessage(
            context: gameViewController.level!.hint!,
            action: {
                controller.closeMenu()
                self.viewController?.delegate.controller = nil
        })
        viewController?.delegate.controller = controller
        controller.toggleMenu()
        completion?()
    }
}

class NGVClearCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.blockTableViewController?.clearBlocks()
        gameViewController.gameMapViewController?.map?.player.resetPosition()
        completion?()
    }
}


class NGVMuteCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.mute = !viewController!.mute
        completion?()
    }
}

class NGVPlayCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        CommandFactory.WebViewClearCommand().execute()
        gameViewController.gameMapViewController?.map?.resetMap()
        CommandFactory.NativeResetAnimationCommand().execute()
        viewController?.clearButton.enabled = false
        gameViewController.gameMapViewController?.map?.player.resetPosition()
        gameViewController.blockTableViewController?.selectedBlock = 0
        gameViewController.blockTableViewController?.submitBlocks()
        CommandFactory.WebViewPlayCommand().execute()
//        viewController?.controlMode = .onStopControls
        gameViewController.gameMapViewController?.animationQueue.first?.executeChainAnimation()
        completion?()
    }
}

class NGVPauseCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.gameMapViewController?.pause()
        completion?()
    }
}

class NGVResumeCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.gameMapViewController?.unpause()
        completion?()
    }
}

class NGVStopCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.clearButton.enabled = true
        completion?()
    }
}

class NGVSwitchControlMode: GameMenuCommand {
    
    var controlMode: GameMenuViewController.ControlMode
    
    init(gameViewController: GameViewController, controlMode: GameMenuViewController.ControlMode) {
        self.controlMode = controlMode
        super.init(gameViewController: gameViewController)
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.controlMode = self.controlMode
    }
}

