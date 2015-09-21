//
//  CustomBlocklyFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 22/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Blockly
import Foundation

class CustomBlocklyFactory {
    
    class func createMoveForwardBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(1)
            $0.appendInput(.Dummy)
                .appendField("Move Forward")
        })
    }
    
    class func createTurnLeftBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(2)
            $0.appendInput(.Dummy)
                .appendField("Turn Left")
        })
    }
    
    class func createTurnRightBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(3)
            $0.appendInput(.Dummy)
                .appendField("Turn Right")
            
        })
    }
    
    class func createDeliverBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(4)
            $0.appendInput(.Dummy)
                .appendField("Deliver")
        })
    }
    
}