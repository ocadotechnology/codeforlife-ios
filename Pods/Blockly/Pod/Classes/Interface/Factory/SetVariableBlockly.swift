//
//  SetVariableBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
    public static func createSetVariableBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.SetVariable) {
                (interpreter, blockly) in
                let arg1 = blockly.args[0]
                let arg2 = blockly.args[1]
                interpreter.vars[arg1] = arg2
                interpreter.proceedToNextBlockly(blockly)
                return -1
            }
            $0.appendInput(.Dummy)
                .appendField("set ")
                .appendFieldTextInput(ReturnType.String)
                .appendField(" to ")
                .appendFieldTextInput(ReturnType.String)
        })
    }
    
}
