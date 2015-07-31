//
//  BlocklyViewController.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class BlocklyViewController: UIViewController {
    
    lazy var topBlocks = [Blockly]()
    private var recognizer: BlocklyPanGestureRecognizer?
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.recognizer = BlocklyPanGestureRecognizer(self)
        view.addGestureRecognizer(self.recognizer!)
    }
    
    override public func viewWillDisappear(animated: Bool) {
        view.removeGestureRecognizer(recognizer!)
    }


    public func addBlockly(blockly: Blockly) {
        view.addSubview(blockly)
        topBlocks.append(blockly)
    }
    
    private var blocklyOnDrag: Blockly?
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case UIGestureRecognizerState.Began:
            let currPos = sender.locationInView(sender.view)
            blocklyOnDrag = ios
            iosfindBlocklyAtPoint(currPos)
        case UIGestureRecognizerState.Changed:
            let translation = sender.translationInView(sender.view!)
            if let blockly = blocklyOnDrag {
                let center = blockly.center
                blockly.center = CGPointMake(center.x + translation.x, center.y + translation.y)
            }
            sender.setTranslation(CGPointZero, inView: sender.view)
        case UIGestureRecognizerState.Ended:
            blocklyOnDrag = nil
        default: break
        }
    }
    
    private func findBlocklyAtPoint(pos: CGPoint) -> Blockly? {
        for subview in view.subviews {
            if let subview = subview as? Blockly where CGRectContainsPoint(subview.frame, pos) {
                return subview
            }
        }
        return nil
    }

}
