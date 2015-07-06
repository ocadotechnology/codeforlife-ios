//
//  GameMenuCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class GameMenuCommand: GameViewCommand {
    
}

class NGVHelpCommand : GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.helpViewController!.message = HelpMessage(
            context: gameViewController.level!.hint!,
            action: gameViewController.helpViewController!.closeMenu)
        gameViewController.helpViewController!.toggleMenu()
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

class NGVPlayCommand: GameMenuCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.gameMapViewController?.map?.player.resetPosition()
        gameViewController.blockTableViewController?.blocks.first?.executeBlockChainAction(gameViewController.gameMapViewController!.map!.player)
        completion()
    }
}
