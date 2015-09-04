//
//  HighlightIncorrectAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class BlocklyHighlightIncorrectAction: BlocklyHighlightAnimation {
    override func execute(completion: (() -> Void)? = nil) {
        println("Highlight Incorrect Cell: \(blockId)")
        delegate?.highlightIncorrectBLock(blockId)
        completion?()
    }
}