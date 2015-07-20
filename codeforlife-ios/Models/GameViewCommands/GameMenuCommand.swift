//
//  GameMenuCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class GameMenuCommand: GameViewCommand {
    weak var viewController: GameMenuViewController? {
        return gameViewController.gameMenuViewController
    }
}

class NGVShowHelpCommand : GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        let controller = MessageViewController.MessageViewControllerInstance()
        controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        SharedContext.MainGameViewController?.presentViewController(controller, animated: true, completion: nil)
        controller.message = HelpMessage(
            context: gameViewController.level!.hint!,
            action: {
                println(controller.view.frame)
                controller.dismissViewControllerAnimated(true, completion: nil)
                self.viewController?.delegate.controller = nil
        })
        viewController?.delegate.controller = controller
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
        viewController?.muted = !viewController!.muted
        completion?()
    }
}

/// Called after control mode changes to onPlayControls
class NGVPlayCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        
        // Web UI Update
        CommandFactory.WebViewClearCommand().execute()
        
        // Native UI Update
        gameViewController.gameMapViewController?.map?.resetMap()
        CommandFactory.NativeResetAnimationCommand().execute()
        gameViewController.blockTableViewController?.clearButton.enabled = false
        
        // Submit Blocks and retrieve Animations
        gameViewController.gameMapViewController?.map?.player.resetPosition()
        
        gameViewController.blockTableViewController?.submitBlocks()
        
        // Execute Animations
        CommandFactory.WebViewPlayCommand().execute()

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

