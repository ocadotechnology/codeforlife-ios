//
//  BlocklyFactory.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class BlocklyFactory {
    
    public init() {}
    
    public func createIfThenBlock() -> Blockly {
        let blockly = Blockly(buildClosure: {
            $0.appendInput(InputType.Value, field: "if")
            $0.appendInput(InputType.Statment, field: "then")
        })
        return blockly
    }
    
    public func createMoveForwardBlock() -> Blockly {
        let blockly = Blockly(buildClosure: {
            $0.appendInput(InputType.Dummy, field: "Move Forward")
        })
        return blockly
    }
    
}
