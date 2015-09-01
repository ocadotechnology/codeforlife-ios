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

class BlocklyRemoveAllBlocksAction: BlocklyAction {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.clearBlocks()
        completion?()
    }
}
