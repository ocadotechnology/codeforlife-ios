//
//  BlocklyDrawer.swift
//  Blockly
//
//  Created by Joey Chan on 07/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class BlocklyDrawer {
    
    static func createCGPath(blockly: UIBlocklyView) -> CGPath {
        
        let cornerRadius = CGFloat(3)
        let PI = CGFloat(M_PI)
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        /* Starting Point */
        path.moveToPoint(CGPointMake(TabSize.height, cornerRadius))
        
        /* Top Left Rounded Corner */
        if blockly.blockly.previousBlockly == nil &&
            blockly.blockly.outputBlockly == nil {
            path.addCurveToPoint(CGPointMake(TabSize.height + cornerRadius, 0),
                controlPoint1: CGPointMake(TabSize.height + cornerRadius - cornerRadius*cos(PI/6), cornerRadius - cornerRadius*sin(PI/6)),
                controlPoint2: CGPointMake(TabSize.height + cornerRadius - cornerRadius*cos(PI/3), cornerRadius - cornerRadius*sin(PI/3)))
        } else {
            path.addLineToPoint(CGPointMake(TabSize.height, 0))
        }
        
        /* Previous Connection Blank */
        if blockly.blockly.previousConnection != nil {
            path.addLineToPoint(CGPointMake(PreviousConnectionOffset.x - BlankSize.width/2, 0))
            path.addLineToPoint(CGPointMake(PreviousConnectionOffset.x, PreviousConnectionOffset.y))
            path.addLineToPoint(CGPointMake(PreviousConnectionOffset.x + BlankSize.width/2, 0))
        }
        
        /* Top Right Rounded Corner */
        path.addLineToPoint(CGPointMake(blockly.frame.width - cornerRadius, 0))
        if blockly.blockly.previousBlockly == nil {
            path.addCurveToPoint(CGPointMake(blockly.frame.width, cornerRadius),
                controlPoint1: CGPointMake(blockly.frame.width - cornerRadius + cornerRadius*sin(PI/6), cornerRadius - cornerRadius*cos(PI/6)),
                controlPoint2: CGPointMake(blockly.frame.width - cornerRadius + cornerRadius*sin(PI/3), cornerRadius - cornerRadius*cos(PI/3)))
        } else {
            path.addLineToPoint(CGPointMake(blockly.frame.width, 0))
        }
        
        
        /** Input Connection Blanks and Tabs */
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
        
        path.addLineToPoint(CGPointMake(blockly.frame.width, blockly.frame.height-TabSize.height - cornerRadius))
        
        /* Bottom Right Rounded Corner */
        if blockly.nextBlockly == nil {
            path.addCurveToPoint(CGPointMake(blockly.frame.width - cornerRadius, blockly.frame.height-TabSize.height),
                controlPoint1: CGPointMake(blockly.frame.width - cornerRadius + cornerRadius*cos(PI/6), blockly.frame.height-TabSize.height - cornerRadius + cornerRadius*sin(PI/6)),
                controlPoint2: CGPointMake(blockly.frame.width - cornerRadius + cornerRadius*cos(PI/3), blockly.frame.height-TabSize.height - cornerRadius + cornerRadius*sin(PI/3)))
        } else {
            path.addLineToPoint(CGPointMake(blockly.frame.width, blockly.frame.height-TabSize.height))
        }
        
        /* Next Connection Tab */
        if blockly.blockly.nextConnection != nil {
            path.addLineToPoint(CGPointMake(NextConnectionOffset.x+TabSize.width/2, blockly.frame.height-TabSize.height))
            path.addLineToPoint(CGPointMake(NextConnectionOffset.x, blockly.frame.height))
            path.addLineToPoint(CGPointMake(NextConnectionOffset.x-TabSize.width/2, blockly.frame.height-TabSize.height))
        }
        
        path.addLineToPoint(CGPointMake(TabSize.height + cornerRadius, blockly.frame.height - TabSize.height))
        
        /* Bottom Left Round Corner */
        if blockly.nextBlockly == nil &&
            blockly.blockly.outputBlockly == nil {
            path.addCurveToPoint(CGPointMake(TabSize.height, blockly.frame.height - TabSize.height - cornerRadius),
                controlPoint1: CGPointMake(TabSize.height + cornerRadius - cornerRadius*sin(PI/6), blockly.frame.height-TabSize.height - cornerRadius + cornerRadius*cos(PI/6)),
                controlPoint2: CGPointMake(TabSize.height + cornerRadius - cornerRadius*sin(PI/3), blockly.frame.height-TabSize.height - cornerRadius + cornerRadius*cos(PI/3)))
        } else {
            path.addLineToPoint(CGPointMake(TabSize.height, blockly.frame.height - TabSize.height))
        }
        
        /* Output Connection Tab */
        if blockly.blockly.outputConnection != nil {
            path.addLineToPoint(CGPointMake(TabSize.height, BlankSize.height + DefaultBlocklySize.height/2 + TabSize.width/2))
            path.addLineToPoint(CGPointMake(0, BlankSize.height + DefaultBlocklySize.height/2))
            path.addLineToPoint(CGPointMake(TabSize.height, BlankSize.height + DefaultBlocklySize.height/2 - TabSize.width/2))
        }
        
        
        path.closePath()
        return path.CGPath
    }

}