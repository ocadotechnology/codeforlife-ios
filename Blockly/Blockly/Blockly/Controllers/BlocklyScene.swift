//
//  BlocklyViewController.swift
//  Blockly
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit

public class BlocklyScene: SKScene {

    private lazy var heads = [Blockly]()
    private var recognizer: BlocklyPanGestureRecognizer?
    
    override public func didMoveToView(view: SKView) {
        self.scaleMode = SKSceneScaleMode.AspectFill
        self.backgroundColor = UIColor.whiteColor()
        self.recognizer = BlocklyPanGestureRecognizer(self)
        view.addGestureRecognizer(self.recognizer!)
    }
    
    override public func willMoveFromView(view: SKView) { view.removeGestureRecognizer(recognizer!) }
    
    public func addHead(newHead: Blockly) {
        heads.append(newHead)
        addBlockly(newHead)
    }
    
    public func addBlockly(newBlockly: Blockly) {
        addChild(newBlockly)
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
            var currPos = sender.locationInView(sender.view)
            currPos = convertPointFromView(currPos)
            if let currBlockly = nodeAtPoint(currPos) as? Blockly {
                blocklyOnDrag = currBlockly.root
            }
        case UIGestureRecognizerState.Changed:
            var translation = sender.translationInView(sender.view!)
            translation = CGPointMake(translation.x, -translation.y)
            if let blockly = blocklyOnDrag {
                let position = blockly.position
                blockly.position = CGPointMake(position.x + translation.x, position.y + translation.y)
                blockly.updateNextPosition()
                blockly.updateChildPosition()
            }
            sender.setTranslation(CGPointZero, inView: sender.view)
        case UIGestureRecognizerState.Ended:
            blocklyOnDrag?.updatePrev()
            blocklyOnDrag?.updateNext()
            blocklyOnDrag?.updateParent()
            blocklyOnDrag?.snapToNeighbour()
            blocklyOnDrag = nil
        default: break
        }
    }
    
}

class BlocklyPanGestureRecognizer: UIPanGestureRecognizer {
    unowned var blocklyScene: BlocklyScene
    init( _ blocklyScene: BlocklyScene) {
        self.blocklyScene = blocklyScene
        super.init(target: blocklyScene, action: Selector("handlePanGesture:"))
    }
}

