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
    
    let FirstButtonOrigin = CGPointMake(20, 30)
    let HeightFromPreviousButton = CGFloat(20)
    let DefaultBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    let NumberOfFingersRequiredToScroll = 2
    
    weak var viewController: BlocklyViewController?
    
    
    var panRecognizer: UIPanGestureRecognizer!
    
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
    
    public func addBlocklyButton(closure: () -> UIBlocklyView) -> BlocklyGenerator {
        let blocklyButton = BlocklyButton()
        blocklyButton.closure = closure
        buttons.append(blocklyButton)
        return self
    }
    
    public func addBlocklyButtons(closures: (() -> UIBlocklyView)...) -> BlocklyGenerator {
        closures.foreach({
            [unowned self] in
            let blocklyButton = BlocklyButton()
            blocklyButton.closure = $0
            self.buttons.append(blocklyButton)
        })
        return self
    }
    
    public func addBlocklyButtons(closures: [() -> UIBlocklyView]) -> BlocklyGenerator {
        closures.foreach({
            [unowned self] in
            let blocklyButton = BlocklyButton()
            blocklyButton.closure = $0
            self.buttons.append(blocklyButton)
            })
        return self
    }
    
    private func displayBlocklyButtons() -> CGFloat {
        view.subviews.foreach({$0.removeFromSuperview()})
        for (index, button) in enumerate(buttons) {
            let blockly = button.closure!()
            let x = FirstButtonOrigin.x
            let y = index < 1 ? FirstButtonOrigin.y : buttons[index-1].frame.origin.y + buttons[index-1].frame.height + HeightFromPreviousButton
            button.frame = CGRect(origin: CGPointMake(x, y), size: blockly.frame.size)
            blockly.frame.origin = CGPointZero
            blockly.shapeLayer.shadowOpacity = 0.05
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
