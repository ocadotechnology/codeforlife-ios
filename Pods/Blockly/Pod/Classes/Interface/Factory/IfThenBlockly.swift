//
//  IfThenBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
    public class func createIfThenBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.IfThen) {
                (interpreter, blockly) in
                if let index = blockly.inputConnections[0].targetConnection?.sourceBlockly.typeId,
                    closure = BlocklyInterpreter.closureMap[index] {
                        if interpreter.lastReg < closure(interpreter, blockly) {
                            if let nextblockly = blockly.inputConnections[1].targetConnection?.sourceBlockly {
                                interpreter.pushReg()
                                return interpreter.proceedToSpecificBlockly(nextblockly)
                            }
                        }
                        return interpreter.proceedToNextBlockly(blockly)
                }
                return interpreter.exit(1)
            }
            $0.appendInput(.Value)
                .appendField("if")
                .setCheck(ReturnType.Boolean)
            $0.appendInput(.Statement)
                .appendField("then")
            
        })
    }
    
}