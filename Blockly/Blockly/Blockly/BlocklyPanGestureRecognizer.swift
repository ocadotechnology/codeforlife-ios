//
//  BlocklyPanGestureRecognizer.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class BlocklyPanGestureRecognizer: UIPanGestureRecognizer {
    unowned var blocklyVC: BlocklyVC
    init( _ blocklyVC: BlocklyVC) {
        self.blocklyVC = blocklyVC
        super.init(target: blocklyVC, action: Selector("handlePanGesture:"))
    }
}