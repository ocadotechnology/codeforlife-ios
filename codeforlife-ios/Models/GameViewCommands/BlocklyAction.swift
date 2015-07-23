//
//  BlocklyAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class BlocklyAction : GameViewAction {
    weak var viewController : BlockTableViewController? {
        return gameViewController?.blockTableViewController
    }
}

class BlocklyAddBlockAction: BlocklyAction {
    
    var block: Block
    
    init(block: Block) {
        self.block = block
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.addBlock(self.block)
        self.block.executeBlock(animated: true, completion: completion)
    }
}

class BlocklyRemoveAllBlocksAction: BlocklyAction {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.clearBlocks()
        completion?()
    }
}
