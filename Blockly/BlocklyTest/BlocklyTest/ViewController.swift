//
//  ViewController.swift
//  BlocklyTest
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Blockly2

class ViewController: BlocklyViewController {
    
    let factory = BlocklyFactory()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let b1 = factory.createMoveForwardBlock()
        let b2 = factory.createMoveForwardBlock()
        let b3 = factory.createTurnLeftBlock()
        let b4 = factory.createIfThenBlock()
        let b5 = factory.createTrueBlock()
        addBlockly(b1)
        addBlockly(b2)
        addBlockly(b3)
        addBlockly(b4)
        addBlockly(b5)
    }

}

