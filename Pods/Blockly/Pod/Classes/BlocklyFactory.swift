//
//  BlocklyFactory.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class BlocklyFactory {
    
    public static func createIfThenBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.IfThen) {
                (interpreter, blockly) in
                if let index = blockly.inputConnections[0].targetConnection?.sourceBlockly.typeId,
                    closure = BlocklyInterpreter.closureMap[index] {
                        if interpreter.lastReg < closure(interpreter, blockly) {
                            if let nextblockly = blockly.inputConnections[1].targetConnection?.sourceBlockly {
                                interpreter.pushReg()
                                interpreter.proceedToSpecificBlockly(nextblockly)
                            }
                        } else {
                            interpreter.proceedToNextBlockly(blockly)
                        }
                } else {
                    interpreter.exit(1)
                }
                return -1
            }
            $0.appendInput(.Value)
                .appendField("if")
                .setCheck(ReturnType.Boolean)
            $0.appendInput(.Statement)
                .appendField("then")
            
        })
    }
    
    public static func createTrueBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure:  {
            $0.setTypeId(BlocklyType.True) {
                (interpreter, blockly) in
                return 1
            }
            $0.setOutput(ReturnType.Boolean)
            $0.appendInput(.Dummy)
                .appendField("true")
            $0.setPreviousStatement(false)
        })
    }
    
    public static func createFalseBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure:  {
            $0.setTypeId(BlocklyType.False) {
                (interpreter, blockly) in
                return 0
            }
            $0.setOutput(ReturnType.Boolean)
            $0.appendInput(.Dummy)
                .appendField("false")
            $0.setPreviousStatement(false)
        })
    }
    
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
                            interpreter.proceedToSpecificBlockly(childblockly)
                        } else {
                            interpreter.lastReg = 0
                            interpreter.proceedToNextBlockly(blockly)
                        }
                    } else {
                        /* while condition returns false */
                        interpreter.lastReg = 0
                        interpreter.proceedToNextBlockly(blockly)
                    }
                }
                return -1
            }
            $0.appendInput(.Value)
                .appendField("repeat")
                .setCheck(ReturnType.Integer)
            $0.appendInput(.Statement)
                .appendField("do")
        })
     }
    
    public static func createStartBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.Start)
            $0.appendInput(.Dummy)
                .appendField("Start")
            $0.mode = BlocklyUIMode.All & ~BlocklyUIMode.Deletable
            $0.setPreviousStatement(false)
        })
      }
    
    public static func createNumberBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.Number) {
                (interpreter, blockly) in
                if let result = blockly.args[0].toInt() {
                    return result
                }
                return -1
            }
            $0.setOutput(ReturnType.Integer)
            $0.setPreviousStatement(false)
            $0.appendInput(.Dummy)
                .appendFieldTextInput(ReturnType.Integer)
                .appendField("times")
        })
    }
    
    public static func createPrintlnBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.Println) {
                (interpreter, blockly) in
                if let stringBlock = blockly.inputConnections.first?.targetConnection?.sourceBlockly,
                    content = stringBlock.args.first {
                    if stringBlock.typeId == BlocklyType.String {
                        println(content)
                    } else if stringBlock.typeId == BlocklyType.GetVariable {
                        if let content = interpreter.vars[content] {
                            println(content)
                        } else {
                            println()
                        }
                    }
                } else {
                    println()
                }
                return interpreter.proceedToNextBlockly(blockly)
            }
            $0.appendInput(.Value)
                .appendField("println")
                .setCheck(ReturnType.String)
        })
    }
    
    public static func createPrintBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.Print) {
                (interpreter, blockly) in
                if let stringBlock = blockly.inputConnections.first?.targetConnection?.sourceBlockly,
                        content = stringBlock.args.first {
                    if stringBlock.typeId == BlocklyType.String {
                        print(content)
                    } else if stringBlock.typeId == BlocklyType.GetVariable {
                        if let content = interpreter.vars[content] {
                            print(content)
                        }
                    }
                }
                interpreter.proceedToNextBlockly(blockly)
                return -1
            }
            $0.appendInput(.Value)
                .appendField("print")
                .setCheck(ReturnType.String)
        })
    }
    
    public static func createStringBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.String)
            $0.setPreviousStatement(false)
            $0.setOutput(ReturnType.String)
            $0.appendInput(.Value)
                .appendField("\"")
                .appendFieldTextInput(ReturnType.String)
                .appendField("\"")
        })
    }
    
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
    
    public static func createGetVariableBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.GetVariable)
            $0.setOutput(ReturnType.String)
            $0.setPreviousStatement(false)
            $0.appendInput(.Dummy)
                .appendFieldTextInput(ReturnType.String)
        })
    }
    
}
