//
//  BlocklyMenu.swift
//  Blockly
//
//  Created by Joey Chan on 30/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public extension BlocklyVC {
    
    func StartBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.center = pos
            $0.backgroundColor = UIColor.greenColor()
            $0.canHaveNext = true
        })
        return blockly
    }
    
    func NormalBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.center = pos
            $0.backgroundColor = UIColor.blueColor()
            $0.canHavePrev = true
            $0.canHaveNext = true
        })
        return blockly
    }
    
    func ConditionalBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.originalSize.height /= 2
            $0.center = pos
            $0.backgroundColor = UIColor.redColor()
            $0.canHaveBigSister = true
            $0.canHaveNext = true
        })
        return blockly
    }
    
    func IfThenBlock(pos: CGPoint) -> [Blockly] {
        let ifBlockly = Blockly.build({
            $0.center = pos
            $0.originalSize.height /= 2
            $0.backgroundColor = UIColor.blackColor()
            $0.canHavePrev = true
            $0.canHaveNext = true
            $0.canHaveLittleSister = true
        })
        let thenBlockly = Blockly.build({
            $0.prev = ifBlockly
            $0.originalSize.width /= 2
            $0.originalSize.height /= 2
            $0.backgroundColor = UIColor.blackColor()
            $0.canHavePrev = true
            $0.canHaveNext = true
            $0.canHaveLittleSister = true
            $0.lockToPrev = true
            $0.snapToNeighbour()
        })
        let endBlockly = Blockly.build({
            $0.originalSize.height /= 2
            $0.prev = thenBlockly
            $0.backgroundColor = UIColor.blackColor()
            $0.canHavePrev = true
            $0.canHaveNext = true
            $0.lockToPrev = true
            $0.snapToNeighbour()
        })
        return [ifBlockly, thenBlockly, endBlockly]
    }
    
}

