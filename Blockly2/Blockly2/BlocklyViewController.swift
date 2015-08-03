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
    
    private weak var blocklyOnDrag: Blockly? {
        willSet {
            self.blocklyOnDrag?.layer.borderWidth = 0
            self.blocklyOnDrag?.updateNeighbour()
        }
        didSet {
            self.blocklyOnDrag?.layer.borderWidth = 5
            self.blocklyOnDrag?.layer.borderColor = UIColor.yellowColor().CGColor
        }
    }
    
    private weak var blocklyOnHighlighted: Blockly? {
        willSet {
            self.blocklyOnHighlighted?.layer.borderWidth = 0
        }
        didSet {
            self.blocklyOnHighlighted?.layer.borderWidth = 5
            self.blocklyOnHighlighted?.layer.borderColor = UIColor.greenColor().CGColor
        }
    }
    
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
    
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case UIGestureRecognizerState.Began:
            /**
             Locate the Blockly which is about to be dragged around
             */
            let currPos = sender.locationInView(sender.view)
            blocklyOnDrag = findBlocklyAtPoint(currPos)
            
        case UIGestureRecognizerState.Changed:
        
            blocklyOnHighlighted = nil
            let translation = sender.translationInView(sender.view!)
            if let blockly = blocklyOnDrag {
                
                /** Update blocklyOnDrag position */
                let center = blockly.center
                blockly.center = CGPointMake(center.x + translation.x, center.y + translation.y)
                
                /** Highlight the closest blockly if one is in search range */
                if let closestBlockly = blockly.findClosestConnection()?.sourceBlock where
                        closestBlockly != blocklyOnDrag?.nextConnection?.targetConnection?.sourceBlock {
                    blocklyOnHighlighted = closestBlockly
                }
            }
            sender.setTranslation(CGPointZero, inView: sender.view)
            
        case UIGestureRecognizerState.Ended:
            blocklyOnHighlighted = nil
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
