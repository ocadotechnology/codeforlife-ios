//
//  BlocklyCustomizationExtension.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

/**
    This file store all the functions which can be called in customization in BlocklyFactory
 */

extension Blockly {
    
    func setTypeId(typeId: Int, closure: Closure? = nil) {
        blocklyCore.typeId = typeId
        if let closure = closure {
            BlocklyInterpreter.closureMap[typeId] = closure
        }
    }
    
    func setNextStatement(allowed: Bool) {
        blocklyCore.setNextStatement(allowed)
    }
    
    func setPreviousStatement(allowed: Bool) {
        blocklyCore.setPreviousStatement(allowed)
    }
    
    func setOutput(returnType: ReturnType) {
        blocklyCore.setOutput(returnType)
    }
    
    func appendDummyInput() -> Input {
        return Input(sourceBlock: self, type: .Dummy)
    }
    
    func appendValueInput() -> Input {
        return Input(sourceBlock: self, type: .Value)
    }
    
    func appendStatementInput() -> Input {
        return Input(sourceBlock: self, type: .Statement)
    }
}
