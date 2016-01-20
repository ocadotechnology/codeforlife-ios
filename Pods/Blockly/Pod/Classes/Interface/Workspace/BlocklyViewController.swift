//
//  BlocklyViewController.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class BlocklyViewController: UIViewController {
    
    private let AnimationDuration = NSTimeInterval(0.2)
    
    public var editable = true
    
    public let blocklyGenerator = BlocklyGenerator()
    public weak var delegate: BlocklyDelegate?
    var recognizer: BlocklyPanGestureRecognizer?
    
    public var trashcan: BlocklyTrashcan!
    public var menuButton: BlocklyMenuButton!
    
    
    public var menuOpen = false { didSet { displayMenu(menuOpen) } }
    
    var connectionPoints: [ConnectionPoint] {
        var connectionPoints = [ConnectionPoint]()
        Workspace.getInstance().blocklys.foreach({
            (blockly) in
            if let blocklyView = blockly.blocklyView as? UIBlocklyView {
                for connectionPoint in blocklyView.connectionPoints {
                    connectionPoints.append(connectionPoint)
                }
            }
        })
        return connectionPoints
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        menuButton = BlocklyMenuButton(blocklyViewController: self)
        trashcan = BlocklyTrashcan(blocklyViewController: self)
        setupBlocklyGenerator()
        setupPanGestureRecognizer()
        setupInterpretButton()
        setupTapRecognizerToDismissKeyboard()
    }
    
    
    public func addBlockly(blockly: UIBlocklyView) {
        view.addSubview(blockly)
        blockly.viewController = self
        Workspace.getInstance().topBlocks.append(blockly.blockly)
        Workspace.getInstance().blocklys.append(blockly.blockly)
    }
    
    public func findBlocklyAtPoint(pos: CGPoint) -> UIBlocklyView? {
        for subview in Array(view.subviews.reverse()) {
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
    
    
    /***************************
     *     Private Methods     *
     ***************************/
    
    private func setupBlocklyGenerator() {
        self.addChildViewController(blocklyGenerator)
        self.view.insertSubview(blocklyGenerator.view, belowSubview: menuButton)
        blocklyGenerator.view.frame = CGRect(origin: view.frame.origin, size: CGSizeMake(BlocklyGeneratorWidth, view.frame.height))
        blocklyGenerator.view.layer.zPosition = 1
        blocklyGenerator.view.frame.origin = self.view.frame.origin - CGPointMake(self.view.frame.width, 0)
        blocklyGenerator.didMoveToParentViewController(self)
    }
    
    private func setupInterpretButton() {
        let interpretButton = UIButton()
        view.addSubview(interpretButton)
        interpretButton.autoresizingMask = [UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleBottomMargin]
        interpretButton.backgroundColor = UIColor.blackColor()
        interpretButton.frame = CGRect(origin: CGPointMake(view.frame.width-100, 0), size: CGSizeMake(100, 100))
        interpretButton.addTarget(self, action: "interpret", forControlEvents: UIControlEvents.TouchDown)
    }
    
    private func setupPanGestureRecognizer() {
        recognizer = BlocklyPanGestureRecognizer(self)
        view.addGestureRecognizer(recognizer!)
    }
    
    private func setupTapRecognizerToDismissKeyboard() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap")
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    private func displayMenu(open: Bool) {
        UIView.animateWithDuration(AnimationDuration, animations: {
            [unowned self] in
            self.blocklyGenerator.view.frame.origin = open ?
                self.view.frame.origin :
                self.view.frame.origin - CGPointMake(self.view.frame.width, 0)
            self.menuButton.frame.origin = open ?
                self.blocklyGenerator.view.frame.origin + CGPointMake(self.blocklyGenerator.view.frame.width, 0) :
                self.view.frame.origin
            })
    }
    
    /**********************************
    *   Gesture Recognizer Selector   *
    ***********************************/
    
    func toggleMenu() { menuOpen = !menuOpen }
    
    func handleSingleTap() { self.view.endEditing(true) }
    
    func handlePanGesture(sender: UIPanGestureRecognizer) { recognizer?.handlePanGesture(sender) }
    
    func interpret() {
        let startBlock = Workspace.getInstance().topBlocks.getItemAtIndex(0)
        BlocklyInterpreter().interpret(startBlock)
    }

}
