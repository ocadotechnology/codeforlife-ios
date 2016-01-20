//
//  RepeatDoBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
    public static func createRepeatDoBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.RepeatDo) {
                (interpreter, blockly) in
                if let numberBlock = blockly.inputConnections[0].targetConnection?.sourceBlockly,
                    closure = BlocklyInterpreter.closureMap[numberBlock.typeId] {
                    if interpreter.lastReg < closure(interpreter, numberBlock) {
                        /* while condition returns true */
                        if let childblockly = blockly.inputConnections[1].targetConnection?.sourceBlockly {
                            interpreter.pushReg()
                            return interpreter.proceedToSpecificBlockly(childblockly)
                        }
                    }
                }
                interpreter.lastReg = 0
                return interpreter.proceedToNextBlockly(blockly)
            }
            $0.appendInput(.Value)
                .appendField("repeat")
                .setCheck(ReturnType.Integer)
            $0.appendInput(.Statement)
                .appendField("do")
        })
    }
    
}
