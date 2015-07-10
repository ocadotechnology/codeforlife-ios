//
//  BlocklyCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class BlocklyCommand : GameViewCommand {}

class NGVAddBlockCommand: BlocklyCommand {
    
    var block: Block
    
    init(gameViewController: GameViewController, block: Block) {
        self.block = block
        super.init(gameViewController: gameViewController)
    }
    
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.blockTableViewController.addBlock(self.block)
    }
}

