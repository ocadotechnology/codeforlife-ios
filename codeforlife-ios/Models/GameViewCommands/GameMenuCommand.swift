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

class GameMenuNativeHelpCommand : GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        let controller = MessageViewController()
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        SharedContext.MainGameViewController?.presentViewController(controller, animated: true, completion: nil)
        controller.message = HelpMessage(
            context: gameViewController.level!.hint!,
            action: {
                controller.dismissViewControllerAnimated(true, completion: nil)
        })
        completion?()
    }
}

class NGVStopCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.gameMapViewController?.map?.resetMap()
        gameViewController.blockTableViewController?.clearBlocks()
        gameViewController.gameMapViewController?.map?.van.reset()
        completion?()
    }
}

class NGVClearCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController.blockTableViewController?.clearBlocks()
        gameViewController.gameMapViewController?.map?.resetMap()
        gameViewController.blockTableViewController?.resetHighlightCellVariables()
        gameViewController.gameMapViewController?.map?.van.reset()
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
        
        // Native UI Update
        gameViewController.gameMapViewController?.map?.resetMap()
        CommandFactory.NativeResetAnimationCommand().execute()
        gameViewController.gameMenuViewController?.clearButton.enabled = false
        gameViewController.blockTableViewController?.goToTopBlock()
        
        // Submit Blocks and retrieve Animations
        gameViewController.gameMapViewController?.map?.van.reset()
        gameViewController.blockTableViewController?.submitBlocks()

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

