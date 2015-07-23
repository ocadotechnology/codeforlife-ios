//
//  BlocklyCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class BlocklyCommand : GameViewCommand {
    weak var viewController : BlockTableViewController? {
        return gameViewController.blockTableViewController
    }
}

class NGVAddBlockCommand: BlocklyCommand {
    
    var block: Block
    
    init(gameViewController: GameViewController, block: Block) {
        self.block = block
        super.init(gameViewController: gameViewController)
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.addBlock(self.block)
        self.block.executeBlock(animated: true, completion: completion)
    }
}

class NGVRemoveAllBlocksCommand: BlocklyCommand {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.clearBlocks()
        completion?()
    }
}
