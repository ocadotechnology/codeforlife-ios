//
//  BlocklyPanGestureRecognizer.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class BlocklyPanGestureRecognizer: UIPanGestureRecognizer {
    
    private weak var blocklyOnDrag: UIBlocklyView? {
        willSet { self.blocklyOnDrag?.state = BlocklyUIState.Normal }
        didSet  { self.blocklyOnDrag?.state = BlocklyUIState.Selected }
    }
    
    private weak var connectionHighlighted: ConnectionPoint? {
        willSet { self.connectionHighlighted?.sourceBlockly.state = BlocklyUIState.Normal }
        didSet  { self.connectionHighlighted?.sourceBlockly.state = BlocklyUIState.Highlighted }
    }
    
    unowned let blocklyVC: BlocklyViewController
    
    init( _ blocklyVC: BlocklyViewController) {
        self.blocklyVC = blocklyVC
        super.init(target: blocklyVC, action: Selector("handlePanGesture:"))
    }
    
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        if blocklyVC.editable {
            switch sender.state {
            case UIGestureRecognizerState.Began:
                let currPos = sender.locationInView(sender.view)
                blocklyOnDrag = blocklyVC.findBlocklyAtPoint(currPos)
                
            case UIGestureRecognizerState.Changed:
                
                connectionHighlighted = nil
                let translation = sender.translationInView(sender.view!)
                if let blockly = blocklyOnDrag {
                    
                    /** Update blocklyOnDrag position */
                    let center = blockly.center
                    blockly.center = CGPointMake(center.x + translation.x, center.y + translation.y)
                    
                    /** Highlight the closest blockly if one is in search range */
                    connectionHighlighted = blockly.findHighlightConnection()
                    
                    blocklyVC.trashcan.open = blocklyVC.trashcan.frame.contains(sender.locationInView(sender.view!))
                    
                }
                sender.setTranslation(CGPointZero, inView: sender.view)
                
            case UIGestureRecognizerState.Ended:
                connectionHighlighted = nil
                var blocklyToBeDeleted: UIBlocklyView?
                if blocklyVC.trashcan.frame.contains(sender.locationInView(sender.view)) ||
                    blocklyVC.blocklyGenerator.view.frame.contains(sender.locationInView(sender.view)){
                        blocklyToBeDeleted = blocklyOnDrag
                }
                blocklyOnDrag = nil
                blocklyVC.trashcan.open = false
                blocklyToBeDeleted?.removeFromWorkspace(false)
            default: break
            }
        }
    }
}