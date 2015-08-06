//
//  InputStatementConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class InputStatementConnection: InputConnection {
    
    override var totalHeight: CGFloat {
        if let targetConnection = targetConnection {
            return sourceInput.frame.height + targetConnection.sourceBlock.totalHeight
        }
        return sourceInput.frame.height + 40 + TabHeight + BlankHeight
    }
    
    override var position: CGPoint {
        get {
            let offset = CGPointMake(sourceInput.sourceBlock.frame.width*3/4, sourceInput.frame.height + TabHeight)
            return sourceInput.sourceBlock.frame.origin + CGPointMake(0,sourceInput.frame.origin.y) + offset
        }
        set {}
    }
    
    init(_ sourceInput: Input) {
        super.init(sourceInput, InputType.Statement)
    }
    
}