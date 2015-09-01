//
//  PathDrawer.swift
//  Blockly
//
//  Created by Joey Chan on 07/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class BlocklyDrawer {
    
    static func createCGPath(blockly: Blockly) -> CGPath {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(TabSize.height, 0))
        if blockly.blocklyCore.previousConnection != nil {
            path.addLineToPoint(CGPointMake(PreviousConnectionOffset.x - BlankSize.width/2, 0))
            path.addLineToPoint(CGPointMake(PreviousConnectionOffset.x, PreviousConnectionOffset.y))
            path.addLineToPoint(CGPointMake(PreviousConnectionOffset.x + BlankSize.width/2, 0))
        }
        path.addLineToPoint(CGPointMake(blockly.frame.width, 0))
        for input in blockly.inputs {
            if input.connectionPoint?.connection is InputValueConnection {
                path.addLineToPoint(CGPointMake(blockly.frame.width, input.center.y - BlankSize.width/2))
                path.addLineToPoint(CGPointMake(blockly.frame.width - BlankSize.height, input.center.y))
                path.addLineToPoint(CGPointMake(blockly.frame.width, input.center.y + BlankSize.width/2))
            } else if input.connectionPoint?.connection is InputStatementConnection {
                path.addLineToPoint(CGPointMake(blockly.frame.width, input.frame.origin.y))
                path.addLineToPoint(CGPointMake(blockly.frame.width*3/4 + TabSize.width/2, input.frame.origin.y))
                path.addLineToPoint(CGPointMake(blockly.frame.width*3/4, input.frame.origin.y + TabSize.height))
                path.addLineToPoint(CGPointMake(blockly.frame.width*3/4 - TabSize.width/2, input.frame.origin.y))
                path.addLineToPoint(CGPointMake(blockly.frame.width*3/4 - PreviousConnectionOffset.x + TabSize.height, input.frame.origin.y))
                path.addLineToPoint(CGPointMake(blockly.frame.width*3/4 - PreviousConnectionOffset.x + TabSize.height, input.frame.origin.y + input.totalHeight - ShelfHeight))
                path.addLineToPoint(CGPointMake(blockly.frame.width, input.frame.origin.y + input.totalHeight - ShelfHeight))
            }
        }
        
        path.addLineToPoint(CGPointMake(blockly.frame.width, blockly.frame.height-TabSize.height))
        if blockly.blocklyCore.nextConnection != nil {
            path.addLineToPoint(CGPointMake(NextConnectionOffset.x+TabSize.width/2, blockly.frame.height-TabSize.height))
            path.addLineToPoint(CGPointMake(NextConnectionOffset.x, blockly.frame.height))
            path.addLineToPoint(CGPointMake(NextConnectionOffset.x-TabSize.width/2, blockly.frame.height-TabSize.height))
        }
        path.addLineToPoint(CGPointMake(TabSize.height, blockly.frame.height - TabSize.height))
        
        if blockly.blocklyCore.outputConnection != nil {
            path.addLineToPoint(CGPointMake(TabSize.height, BlankSize.height + DefaultBlocklySize.height/2 + TabSize.width/2))
            path.addLineToPoint(CGPointMake(0, BlankSize.height + DefaultBlocklySize.height/2))
            path.addLineToPoint(CGPointMake(TabSize.height, BlankSize.height + DefaultBlocklySize.height/2 - TabSize.width/2))
        }
        path.closePath()
        return path.CGPath
    }

}