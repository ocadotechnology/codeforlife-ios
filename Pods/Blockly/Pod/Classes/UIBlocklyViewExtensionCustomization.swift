//
//  BlocklyCustomizationExtension.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

/**
    In order to avoid having too many lines of code in one file,
    this file stores all the functions which can be called in customization in BlocklyFactory
 */

public extension UIBlocklyView {
    
    public func setTypeId(typeId: Int, closure: Closure? = nil) {
        blockly.typeId = typeId
        if let closure = closure {
            BlocklyInterpreter.closureMap[typeId] = closure
        }
    }
    
    public func setNextStatement(allowed: Bool) {
        blockly.setNextStatement(allowed)
    }
    
    public func setPreviousStatement(allowed: Bool) {
        blockly.setPreviousStatement(allowed)
    }
    
    public func setOutput(returnType: Int) {
        blockly.setOutput(returnType)
    }
    
    public func appendInput(inputType: InputType) -> Input {
        return Input(sourceBlock: self, type: inputType)
    }
}
