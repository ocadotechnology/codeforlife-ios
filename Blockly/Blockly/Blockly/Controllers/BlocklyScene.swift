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
        addHead(StartBlock(CGPointMake(500, 500)))
        addBlockly(NormalBlock(CGPointMake(200, 200)))
        addBlockly(NormalBlock(CGPointMake(300, 300)))
        addBlockly(ConditionalBlock(CGPointMake(400, 400)))
    }
    
    public func addHead(newHead: Blockly) {
        heads.append(newHead)
        addBlockly(newHead)
    }
    
    public func addBlockly(newBlockly: Blockly) {
        view.addSubview(newBlockly)
    }
    
    private func StartBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.center = pos
            $0.backgroundColor = UIColor.greenColor()
            $0.prevSnappingEnabled = false
        })
        return blockly
    }
    
    private func NormalBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.center = pos
            $0.backgroundColor = UIColor.blueColor()
        })
        return blockly
    }
    
    private func ConditionalBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.originalSize.height /= 2
            $0.center = pos
            $0.backgroundColor = UIColor.redColor()
            $0.parentSnappingEnabled = true
        })
        return blockly
    }
    
    private func SisteBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.originalSize.height /= 2
            $0.center = pos
            $0.backgroundColor = UIColor.brownColor()
            $0.prevSnappingEnabled = false
            $0.nextSnappingEnabled = false
        })
        return blockly
    }
    
    private func IfThenBlock(pos: CGPoint) -> [Blockly] {
        let ifBlockly = Blockly.build({
            $0.center = pos
            $0.originalSize.height /= 2
            $0.backgroundColor = UIColor.blackColor()
            $0.parentSnappingEnabled = true
        })
        let thenBlockly = Blockly.build({
            $0.prev = ifBlockly
            $0.originalSize.width /= 4
            $0.originalSize.height /= 2
            $0.backgroundColor = UIColor.yellowColor()
            $0.lockPrev = true
            $0.snapToNeighbour()
        })
        let endBlockly = Blockly.build({
            $0.frame.size.height /= 2
            $0.prev = thenBlockly
            $0.backgroundColor = UIColor.grayColor()
            $0.lockPrev = true
            $0.snapToNeighbour()
        })
        return [ifBlockly, thenBlockly, endBlockly]
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
            blocklyOnDrag?.updateParent()
            blocklyOnDrag?.updatePrev()
            blocklyOnDrag?.updateNext()
            blocklyOnDrag?.snapToNeighbour()
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

