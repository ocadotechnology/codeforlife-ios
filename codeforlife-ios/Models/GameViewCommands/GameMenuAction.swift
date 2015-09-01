//
//  GameMenuAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class GameMenuAction: GameViewAction {
    weak var viewController: GameMenuViewController? {
        return gameViewController?.gameMenuViewController
    }
}

class GameMenuHelpAction : GameMenuAction {
    override func execute(completion: (() -> Void)? = nil) {
        let controller = MessageViewController()
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        gameViewController?.presentViewController(controller, animated: true, completion: nil)
        controller.message = HelpMessage(
            context: gameViewController!.level!.hint,
            action: {
                controller.dismissViewControllerAnimated(true, completion: nil)
        })
        completion?()
    }
}

class GameMenuStopAction: GameMenuAction {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController?.gameMapViewController?.map?.resetMap()
        gameViewController?.blockTableViewController?.clearBlocks()
        gameViewController?.gameMapViewController?.map?.van.reset()
        completion?()
    }
}

class GameMenuClearAction: GameMenuAction {
    override func execute(completion: (() -> Void)? = nil) {
        gameViewController?.blockTableViewController?.clearBlocks()
        gameViewController?.gameMapViewController?.map?.resetMap()
        gameViewController?.blockTableViewController?.resetHighlightCellVariables()
        gameViewController?.gameMapViewController?.map?.van.reset()
        completion?()
    }
}


class GameMenuMuteAction: GameMenuAction {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.muted = !viewController!.muted
        completion?()
    }
}

/// Called after control mode changes to onPlayControls
class GameMenuPlayAction: GameMenuAction {
    override func execute(completion: (() -> Void)? = nil) {
        
        // Native UI Update
        gameViewController?.gameMapViewController?.map?.resetMap()
        ActionFactory.createAction("ResetAnimation").execute()
        viewController?.clearButton.enabled = false
        
        // Submit Blocks and retrieve Animations
        gameViewController?.gameMapViewController?.map?.van.reset()
        gameViewController?.blockTableViewController?.submitBlocks()

    }
}

class GameMenuSwitchControlModeAction: GameMenuAction {
    
    var controlMode: GameMenuViewController.ControlMode
    
    init(controlMode: GameMenuViewController.ControlMode) {
        self.controlMode = controlMode
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.controlMode = self.controlMode
        completion?()
    }
}

