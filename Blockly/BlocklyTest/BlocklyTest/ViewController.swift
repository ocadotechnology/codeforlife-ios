//
//  ViewController.swift
//  BlocklyTest
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Blockly

class ViewController: BlocklyVC {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addHead(StartBlock(CGPointMake(500, 500)))
        addBlockly(NormalBlock(CGPointMake(200, 200)))
        addBlockly(NormalBlock(CGPointMake(300, 300)))
        addBlockly(ConditionalBlock(CGPointMake(400, 400)))
        addBlocklyArray(IfThenBlock(CGPointMake(600, 600)))
    }



}

