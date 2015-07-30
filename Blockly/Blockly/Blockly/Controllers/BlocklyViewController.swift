//
//  BlocklyViewController.swift
//  Blockly
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit

public class BlocklyVC: UIViewController {

    private lazy var heads = [Blockly]()
    private var recognizer: BlocklyPanGestureRecognizer?
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.recognizer = BlocklyPanGestureRecognizer(self)
        view.addGestureRecognizer(self.recognizer!)
    }
    
    override public func viewWillDisappear(animated: Bool) {
        view.removeGestureRecognizer(recognizer!)
    }
    
    public func addHead(newHead: Blockly) {
        heads.append(newHead)
        addBlockly(newHead)
    }
    
    public func addBlockly(newBlockly: Blockly) {
        view.addSubview(newBlockly)
    }
    
    public func addBlocklyArray(newBlockly: [Blockly]) {
        for part in newBlockly {
            view.addSubview(part)
        }
    }
    
    
    
    /**
     Handle the snapping behaviour of the blocklys
     UIGestureRecognizerState.Began: Locate the blockly at point if there exists one
     UIGestureRecognizerState.Changed: Update the located blockly position along with the blocklys linked after, to follow the point and discover if there is any blockly found in neighbour area
     */
    private var blocklyOnDrag: Blockly?
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case UIGestureRecognizerState.Began:
            let currPos = sender.locationInView(sender.view)
            if let currBlockly = findBlocklyAtPoint(currPos) {
                blocklyOnDrag = currBlockly.root
            }
        case UIGestureRecognizerState.Changed:
            let translation = sender.translationInView(sender.view!)
            if let blockly = blocklyOnDrag {
                let center = blockly.center
                blockly.center = CGPointMake(center.x + translation.x, center.y + translation.y)
            }
            sender.setTranslation(CGPointZero, inView: sender.view)
        case UIGestureRecognizerState.Ended:
            blocklyOnDrag?.updateBigSister()
            blocklyOnDrag?.updatePrev()
            blocklyOnDrag?.updateNext()
            blocklyOnDrag?.snapToNeighbour()
            println(blocklyOnDrag?.count)
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

class BlocklyPanGestureRecognizer: UIPanGestureRecognizer {
    unowned var blocklyVC: BlocklyVC
    init( _ blocklyVC: BlocklyVC) {
        self.blocklyVC = blocklyVC
        super.init(target: blocklyVC, action: Selector("handlePanGesture:"))
    }
}

