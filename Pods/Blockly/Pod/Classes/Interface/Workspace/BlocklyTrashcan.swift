//
//  Trashcan.swift
//  Blockly
//
//  Created by Joey Chan on 12/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class BlocklyTrashcan: UIView {
    
    let TrashCanColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).CGColor
    let TrashcanOpacity = Float(0.8)
    let DefaultSize = CGSizeMake(60, 60)
    let DefaultBackgroundColor = UIColor.clearColor()
    let TrashcanHeadMovement = CGFloat(30)
    
    public var open = false {
        willSet {
            if open != newValue {
                trashCanHead.position.y += newValue ? -TrashcanHeadMovement : TrashcanHeadMovement
                trashCanHead.opacity += newValue ? 0.2 : -0.2
                trashCanBody.opacity += newValue ? 0.2 : -0.2
            }
        }
    }
    
    var trashCanHead: CAShapeLayer!
    var trashCanBody: CAShapeLayer!
    
    weak var blocklyViewController: BlocklyViewController?
    
    public init(blocklyViewController: BlocklyViewController) {
        self.blocklyViewController = blocklyViewController
        super.init(frame: CGRect(
            origin: CGPointMake(
                blocklyViewController.view.frame.width - DefaultSize.width - 5,
                blocklyViewController.view.frame.height - DefaultSize.height - 5),
            size: DefaultSize))
        self.backgroundColor = DefaultBackgroundColor
        self.autoresizingMask = [UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleTopMargin]
        blocklyViewController.view.addSubview(self)
        self.draw()
    }
    
    private func draw() {
        trashCanBody = CAShapeLayer()
        trashCanBody.path = createTrashCanBodyPath().CGPath
        trashCanBody.fillColor = TrashCanColor
        trashCanBody.opacity = TrashcanOpacity
        self.layer.addSublayer(trashCanBody)
        
        trashCanHead = CAShapeLayer()
        trashCanHead.path = createTrashCanHeadPath().CGPath
        trashCanHead.fillColor = TrashCanColor
        trashCanHead.opacity = TrashcanOpacity
        self.layer.addSublayer(trashCanHead)
    }
    
    private func createTrashCanBodyPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(frame.width*1/16, 0))
        path.addLineToPoint(CGPointMake(frame.width*15/16, 0))
        path.addLineToPoint(CGPointMake(frame.width*14/16, frame.height))
        path.addLineToPoint(CGPointMake(frame.width*2/16, frame.height))
        path.closePath()
        return path
    }
    
    private func createTrashCanHeadPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, -DefaultSize.height*1/5))
        path.addLineToPoint(CGPointMake(frame.width, -DefaultSize.height*1/5))
        path.addLineToPoint(CGPointMake(frame.width, -DefaultSize.height*1/15))
        path.addLineToPoint(CGPointMake(0, -DefaultSize.height*1/15))
        path.closePath()
        return path
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
