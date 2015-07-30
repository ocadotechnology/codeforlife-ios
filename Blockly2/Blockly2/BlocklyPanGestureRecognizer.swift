//
//  BlocklyPanGestureRecognizer.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class BlocklyPanGestureRecognizer: UIPanGestureRecognizer {
    unowned var blocklyVC: BlocklyViewController
    init( _ blocklyVC: BlocklyViewController) {
        self.blocklyVC = blocklyVC
        super.init(target: blocklyVC, action: Selector("handlePanGesture:"))
    }
}