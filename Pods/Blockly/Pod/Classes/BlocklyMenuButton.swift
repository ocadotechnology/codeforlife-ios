//
//  MenuButton.swift
//  Blockly
//
//  Created by Joey Chan on 12/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class BlocklyMenuButton: UIButton {
    
    weak var blocklyViewController: BlocklyViewController?
    
    func setup(blocklyViewController: BlocklyViewController) {
        self.blocklyViewController = blocklyViewController
        blocklyViewController.view.addSubview(self)
        self.layer.zPosition = 1
        self.frame = CGRect(
            origin: blocklyViewController.view.frame.origin,
            size: BlocklyGeneratorButtonSize)
        self.backgroundColor = UIColor.clearColor()
        self.addTarget(blocklyViewController, action: "toggleMenu", forControlEvents: UIControlEvents.TouchDown)
    }
    
}