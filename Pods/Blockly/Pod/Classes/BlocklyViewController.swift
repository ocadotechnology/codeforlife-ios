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
    public var editable = true
    
    var recognizer: BlocklyPanGestureRecognizer?
    
    public var menuButton: BlocklyMenuButton!
    public var trashcan: BlocklyTrashcan!
    
    var menuOpen = false {
        didSet {
            UIView.animateWithDuration(AnimationDuration, animations: {
                [unowned self] in
                self.blocklyGenerator.view.frame.origin = self.menuOpen ?
                    self.view.frame.origin :
                    self.view.frame.origin - CGPointMake(self.view.frame.width, 0)
                self.menuButton.frame.origin = self.menuOpen ?
                    self.blocklyGenerator.view.frame.origin + CGPointMake(self.blocklyGenerator.view.frame.width, 0) :
                    self.view.frame.origin
                })
        }
    }
    
    var connectionPoints: [ConnectionPoint] {
        var connectionPoints = [ConnectionPoint]()
        view.subviews.foreachBlockly({ blockly in
            for connectionPoint in blockly.connectionPoints {
                connectionPoints.append(connectionPoint)
            }
        })
        return connectionPoints
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        menuButton = BlocklyMenuButton(blocklyViewController: self)
        trashcan = BlocklyTrashcan(blocklyViewController: self)
        setupBlocklyGenerator()
        setupGestureRecognizer()
//        setupInterpretButton()
    }
    
    public func endEditing() {
        self.view.endEditing(true)
    }
    
    public func addBlockly(blocklyView: UIBlocklyView) {
        view.addSubview(blocklyView)
        blocklyView.viewController = self
        Workspace.getInstance().topBlocks.append(blocklyView.blockly)
    }
    
    func findBlocklyAtPoint(pos: CGPoint) -> UIBlocklyView? {
        for subview in view.subviews.reverse() {
            if let subview = subview as? UIBlocklyView where
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
    }

}
