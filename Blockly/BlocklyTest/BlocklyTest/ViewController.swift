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
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let blockly = BlocklyFactory().createIfThenBlock()
        addBlockly(blockly)
    }



}

