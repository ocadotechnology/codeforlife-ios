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
    
    let TrashCanColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).CGColor
    let DefaultSize = CGSizeMake(60, 60)
    let DefaultBackgroundColor = UIColor.clearColor()
    
    weak var blocklyViewController: BlocklyViewController?
    
    func setup(blocklyViewController: BlocklyViewController) {
        self.blocklyViewController = blocklyViewController
        blocklyViewController.view.addSubview(self)
        self.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin
        self.frame = CGRect(
            origin: CGPointMake(blocklyViewController.view.frame.width - DefaultSize.width - 5, blocklyViewController.view.frame.height - DefaultSize.height - 5),
            size: DefaultSize)
        self.backgroundColor = DefaultBackgroundColor
        self.draw()
    }
    
    private func draw() {
        let trashCanBody = CAShapeLayer()
        trashCanBody.path = createTrashCanBodyPath().CGPath
        trashCanBody.fillColor = TrashCanColor
        self.layer.addSublayer(trashCanBody)
        
        let trashCanHead = CAShapeLayer()
        trashCanHead.path = createTrashCanHeadPath().CGPath
        trashCanHead.fillColor = TrashCanColor
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
    
}
