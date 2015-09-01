//
//  BlocklyViewController.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class BlocklyViewController: UIViewController {
    
    let AnimationDuration = NSTimeInterval(0.2)
    
    public let blocklyGenerator = BlocklyGenerator()
    
    public weak var delegate: BlocklyDelegate?
    
    var recognizer: BlocklyPanGestureRecognizer?
    
    public let menuButton = BlocklyMenuButton()
    public let trashcan = BlocklyTrashcan()
    
    var menuOpen = false
    
    var connectionPoints: [ConnectionPoint] {
        var connectionPoints = [ConnectionPoint]()
        view.subviews.foreachBlockly({ blockly in
            for connectionPoint in blockly.connectionPoints {
                connectionPoints.append(connectionPoint)
            }
        })
        return connectionPoints
    }
    
    public var editable = true
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        menuButton.setup(self)
        trashcan.setup(self)
        setupBlocklyGenerator()
        setupGestureRecognizer()
//        setupInterpretButton()
    }
    
    public func addBlockly(blockly: Blockly) {
        view.addSubview(blockly)
        blockly.viewController = self
        Workspace.topBlocks.append(blockly.blocklyCore)
    }
    
    func findBlocklyAtPoint(pos: CGPoint) -> Blockly? {
        for subview in view.subviews.reverse() {
            if let subview = subview as? Blockly where
                CGRectContainsPoint(subview.frame, pos) &&
                    CGPathContainsPoint(subview.shapeLayer.path, nil, pos - subview.frame.origin, true) {
                        return subview
            }
        }
        return nil
    }
    
    override public func viewWillDisappear(animated: Bool) {
        view.removeGestureRecognizer(recognizer!)
        blocklyGenerator.willMoveToParentViewController(nil)
        blocklyGenerator.view.removeFromSuperview()
        blocklyGenerator.removeFromParentViewController()
    }
    
    func toggleMenu() {
        menuOpen = !menuOpen
        UIView.animateWithDuration(AnimationDuration, animations: {
            [unowned self, unowned blocklyGenerator, unowned menuButton] in
            blocklyGenerator.view.frame.origin = self.menuOpen ?
                self.view.frame.origin :
                self.view.frame.origin - CGPointMake(self.view.frame.width, 0)
            menuButton.frame.origin = self.menuOpen ?
                self.blocklyGenerator.view.frame.origin + CGPointMake(self.blocklyGenerator.view.frame.width, 0) :
                self.view.frame.origin
            })
    }

}
