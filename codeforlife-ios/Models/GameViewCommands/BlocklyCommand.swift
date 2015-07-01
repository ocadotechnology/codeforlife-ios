//
//  BlocklyCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class BlocklyCommand {}

class NGVAddBlockCommand: GameViewCommand {
    
    var block: Block
    
    init(gameViewController: GameViewController, block: Block) {
        self.block = block
        super.init(gameViewController: gameViewController)
    }
    
    override func executeWithCompletionHandler(completion: () -> Void) {
        BlockTableViewController.sharedInstance.addBlock(self.block)
    }
}

