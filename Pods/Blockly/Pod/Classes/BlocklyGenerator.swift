//
//  BlocklyGenerator.swift
//  Blockly
//
//  Created by Joey Chan on 10/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class BlocklyGenerator: UIViewController, UIScrollViewDelegate {
    
    let FirstButtonOrigin = CGPointMake(20, 100)
    let HeightFromPreviousButton = CGFloat(30)
    let DefaultBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.02)
    let NumberOfFingersRequiredToScroll = 2
    
    weak var viewController: BlocklyViewController?
    
    var buttons = [BlocklyButton]() {
        didSet {
            if isViewLoaded() {
                displayBlocklyButtons()
            }
        }
    }
    
    override public func viewDidLoad() {
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleHeight
        self.view = UIScrollView(frame: view.bounds)
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.viewController = parentViewController as? BlocklyViewController
        view.backgroundColor = DefaultBackgroundColor
        let contentHeight = displayBlocklyButtons()
        let scrollView = view as! UIScrollView
        scrollView.contentSize = CGSizeMake(BlocklyGeneratorWidth, contentHeight)
        scrollView.panGestureRecognizer.minimumNumberOfTouches = NumberOfFingersRequiredToScroll
        scrollView.delegate = self
    }
    
    public func addBlocklyButton(closure: () -> Blockly) {
        let blocklyButton = BlocklyButton()
        blocklyButton.closure = closure
        buttons.append(blocklyButton)
    }
    
    private func displayBlocklyButtons() -> CGFloat {
        view.subviews.foreach({$0.removeFromSuperview()})
        for (index, button) in enumerate(buttons) {
            let blockly = button.closure!()
            let x = FirstButtonOrigin.x
            let y = index < 1 ? FirstButtonOrigin.y : buttons[index-1].frame.origin.y + buttons[index-1].frame.height + HeightFromPreviousButton
            button.frame = CGRect(origin: CGPointMake(x, y), size: blockly.frame.size)
            blockly.frame.origin = CGPointZero
            button.addSubview(blockly)
            button.viewController = viewController
            view.addSubview(button)
        }
        if let lastBlocklyButton = buttons.last {
            return lastBlocklyButton.frame.origin.y + lastBlocklyButton.frame.height + HeightFromPreviousButton
        }
        return view.frame.height
    }

}
