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
    func execute(completion: () -> Void)
}

class GameViewCommand : Command {
    
    var gameViewController: GameViewController
    
    init(gameViewController: GameViewController ) {
        self.gameViewController = gameViewController
    }
    
    func execute(response: () -> Void) {
        fatalError("Absract GameViewCommand method called")
    }
    
}

class NGVHelpCommand : GameViewCommand {
    override func execute(completion: () -> Void) {
        gameViewController.helpViewController!.message = HelpMessage(
            context: gameViewController.level!.hint!,
            action: gameViewController.helpViewController!.closeMenu)
        gameViewController.helpViewController!.toggleMenu()
    }
}

class NGVClearCommand: GameViewCommand {
    override func execute(completion: () -> Void) {
        gameViewController.blockTableViewController?.clearBlocks()
        gameViewController.gameMapViewController?.map?.resetVanPosition()
    }
}
