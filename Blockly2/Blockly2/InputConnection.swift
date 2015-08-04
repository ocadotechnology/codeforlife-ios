//
//  InputConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 04/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class InputConnection {
    
    var sourceInput: Input
    var inputType: InputType
    
    var position: CGPoint {
        let offset = CGPointMake(sourceInput.frame.width, sourceInput.frame.height/2)
        return sourceInput.sourceBlock.frame.origin + offset
    }
    
    init(_ sourceInput: Input, _ inputType: InputType) {
        self.sourceInput = sourceInput
        self.inputType = inputType
    }
    
}