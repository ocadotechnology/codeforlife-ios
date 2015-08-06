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
            self.blocklyOnDrag?.shapeLayer.lineWidth = 1
            self.blocklyOnDrag?.shapeLayer.strokeColor = UIColor.grayColor().CGColor
            self.blocklyOnDrag?.updateNeighbour()
        }
        didSet {
            self.blocklyOnDrag?.shapeLayer.lineWidth = 3
            self.blocklyOnDrag?.shapeLayer.strokeColor = UIColor.yellowColor().CGColor
        }
    }
    
    private weak var connectionHighlighted: Connection? {
        willSet {
            self.connectionHighlighted?.sourceBlock.shapeLayer.lineWidth = 1
            self.connectionHighlighted?.sourceBlock.shapeLayer.strokeColor = UIColor.grayColor().CGColor
        }
        didSet {
            self.connectionHighlighted?.sourceBlock.shapeLayer.lineWidth = 3
            self.connectionHighlighted?.sourceBlock.shapeLayer.strokeColor = UIColor.greenColor().CGColor
        }
    }
    
    var connections: [Connection] {
        var connections = [Connection]()
        for subview in view.subviews {
            if let blockly = subview as? Blockly {
                for connection in blockly.connections {
                    connections.append(connection)
                }
            }
        }
        return connections
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
        blockly.workspace = self
        view.addSubview(blockly)
        topBlocks.append(blockly)
    }
    
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case UIGestureRecognizerState.Began:
            let currPos = sender.locationInView(sender.view)
            blocklyOnDrag = findBlocklyAtPoint(currPos)
            
        case UIGestureRecognizerState.Changed:
        
            connectionHighlighted = nil
            let translation = sender.translationInView(sender.view!)
            if let blockly = blocklyOnDrag {
                
                /** Update blocklyOnDrag position */
                let center = blockly.center
                blockly.center = CGPointMake(center.x + translation.x, center.y + translation.y)
                
                /** Highlight the closest blockly if one is in search range */
                connectionHighlighted = blockly.findHighlightConnection()
                
            }
            sender.setTranslation(CGPointZero, inView: sender.view)
            
        case UIGestureRecognizerState.Ended:
            connectionHighlighted = nil
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
