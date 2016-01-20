//
//  IfThenElseBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
    public static func createIfThenElseBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.appendInput(.Value)
                .appendField("if")
                .setCheck(ReturnType.Boolean)
            $0.appendInput(.Statement)
                .appendField("then")
            $0.appendInput(.Statement)
                .appendField("else")
            $0.setTypeId(BlocklyType.IfThenElse) {
                (interpreter, blockly) in
                if let closure = interpreter.getIfClosure(blockly) {
                    /** If condition exists */
                    if interpreter.lastReg > 0 {
                        /* This blockly has been evaluated */
                        return interpreter.proceedToNextBlockly(blockly)
                    }
                    if closure(interpreter, blockly) == 1,
                        let thenBlockly = blockly.inputConnections[1].targetConnection?.sourceBlockly {
                            /** `If condition` returns true and `Then clause` exists */
                            interpreter.pushReg()
                            return interpreter.proceedToSpecificBlockly(thenBlockly)
                    } else if let elseBlockly = blockly.inputConnections[2].targetConnection?.sourceBlockly {
                        /** `If condition` returns false and `Else clause` exists */
                        interpreter.pushReg()
                        return interpreter.proceedToSpecificBlockly(elseBlockly)
                    }
                    return interpreter.proceedToNextBlockly(blockly)
                }
                return interpreter.exit(1)
            }
        })
    }
    
}
