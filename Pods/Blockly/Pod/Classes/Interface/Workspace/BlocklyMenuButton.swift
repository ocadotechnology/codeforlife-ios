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
    
    public init(blocklyViewController: BlocklyViewController) {
        self.blocklyViewController = blocklyViewController
        super.init(frame: CGRect(
                            origin: blocklyViewController.view.frame.origin,
                            size: CGSizeMake(20, blocklyViewController.view.frame.height)))
        self.layer.zPosition = 1
        self.backgroundColor = UIColor.blueColor()
        blocklyViewController.view.addSubview(self)
        self.addTarget(blocklyViewController, action: "toggleMenu", forControlEvents: UIControlEvents.TouchDown)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}