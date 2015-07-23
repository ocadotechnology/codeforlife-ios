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
        return gameViewController?.gameMenuViewController
    }
}

class GameMenuHelpCommand : GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        let controller = MessageViewController()
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        gameViewController?.presentViewController(controller, animated: true, completion: nil)
        controller.message = HelpMessage(
            context: gameViewController!.level!.hint!,
            action: {
                controller.dismissViewControllerAnimated(true, completion: nil)
        })
        completion?()
    }
}

class GameMenuStopCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController?.gameMapViewController?.map?.resetMap()
        gameViewController?.blockTableViewController?.clearBlocks()
        gameViewController?.gameMapViewController?.map?.van.reset()
        completion?()
    }
}

class GameMenuClearCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController?.blockTableViewController?.clearBlocks()
        gameViewController?.gameMapViewController?.map?.resetMap()
        gameViewController?.blockTableViewController?.resetHighlightCellVariables()
        gameViewController?.gameMapViewController?.map?.van.reset()
        completion?()
    }
}


class GameMenuMuteCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.muted = !viewController!.muted
        completion?()
    }
}

/// Called after control mode changes to onPlayControls
class GameMenuPlayCommand: GameMenuCommand {
    override func execute(completion: (() -> Void)? = nil) {
        
        // Native UI Update
        gameViewController?.gameMapViewController?.map?.resetMap()
        CommandFactory.createCommand("ResetAnimation").execute()
        viewController?.clearButton.enabled = false
        gameViewController?.blockTableViewController?.goToTopBlock()
        
        // Submit Blocks and retrieve Animations
        gameViewController?.gameMapViewController?.map?.van.reset()
        gameViewController?.blockTableViewController?.submitBlocks()

    }
}

class GameMenuSwitchControlModeCommand: GameMenuCommand {
    
    var controlMode: GameMenuViewController.ControlMode
    
    init(controlMode: GameMenuViewController.ControlMode) {
        self.controlMode = controlMode
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.controlMode = self.controlMode
    }
}

