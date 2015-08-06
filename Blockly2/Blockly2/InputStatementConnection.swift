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
        return 40 + 10 + 10 + (targetConnection == nil ? 40 : max(40, targetConnection!.sourceBlock.totalHeight))
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