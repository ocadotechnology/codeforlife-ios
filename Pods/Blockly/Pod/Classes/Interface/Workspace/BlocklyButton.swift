//
//  BlocklyButton.swift
//  Blockly
//
//  Created by Joey Chan on 12/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class BlocklyButton: UIButton {

    private var firstMoved = true
    weak var viewController: BlocklyViewController?
    var closure: (() -> UIBlocklyView)?
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if firstMoved {
            let blockly = closure!()
            let scrollView = viewController!.blocklyGenerator.view as! UIScrollView
            if let _ = touches.first {
                blockly.center = center - scrollView.contentOffset
                viewController?.addBlockly(blockly)
                firstMoved = false
            }
        }
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        firstMoved = true
    }
    
}