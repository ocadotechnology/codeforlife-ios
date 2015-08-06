//
//  InputValueConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class InputValueConnection: InputConnection {
    
    override var totalHeight: CGFloat {
        return 40
    }
    
    override var position: CGPoint {
        get {
            let offset = CGPointMake(sourceInput.frame.width, sourceInput.frame.height/2)
            return sourceInput.sourceBlock.frame.origin + sourceInput.frame.origin + offset
        }
        set {}
    }
    
    init(_ sourceInput: Input) {
        super.init(sourceInput, InputType.Value)
        
    }
    
}