//
//  HighlightAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class BlocklyHighlightAnimation: Animation {
    
    let blockId: Int
    
    init(delegate: GameViewControllerDelegate?, blockId: Int) {
        self.blockId = blockId
        super.init(delegate: delegate)
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        print("Highlight Cell: \(blockId)")
        delegate?.highlightCorrectBlock(blockId)
        completion?()
    }
}