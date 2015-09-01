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
    
    public static func createMoveForwardBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(1) {
                (interpreter, blocklyCore, i) in
                println("MoveForward")
                interpreter.proceedToNextBlock(blocklyCore, i)
                return -1
            }
            $0.appendDummyInput()
                .appendField("Move Forward")
        })
    }
    
    public static func createTurnLeftBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(2) {
                (interpreter, blocklyCore, i) in
                println("Turn Left")
                interpreter.proceedToNextBlock(blocklyCore, i)
                return -1
            }
            $0.appendDummyInput()
                .appendField("Turn Left")
        })
    }
    
    public static func createTurnRightBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(3) {
                (interpreter, blocklyCore, i) in
                println("Turn Right")
                interpreter.proceedToNextBlock(blocklyCore, i)
                return -1
            }
            $0.appendDummyInput()
                .appendField("Turn Right")
            
        })
    }
    
    public static func createDeliverBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(4)
            $0.appendDummyInput()
                .appendField("Deliver")
        })
    }
    
    public static func createIfThenBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(5) {
                (interpreter, blocklyCore, i) in
                if let index = blocklyCore.inputConnections[0].targetConnection?.sourceBlock.typeId,
                    closure = BlocklyInterpreter.closureMap[index] {
                        if closure(interpreter, blocklyCore, i) == 1 {
                            if let nextBlocklyCore = blocklyCore.inputConnections[1].targetConnection?.sourceBlock {
                                interpreter.proceedToSpecificBlock(nextBlocklyCore, i)
                            }
                        } else {
                            interpreter.proceedToNextBlock(blocklyCore, i)
                        }
                } else {
                    interpreter.exit(1)
                }
                return -1
            }
            $0.appendValueInput()
                .appendField("if")
                .setCheck(.Boolean)
            $0.appendStatementInput()
                .appendField("then")
            
        })
    }
    
    public static func createTrueBlock() -> Blockly {
        return Blockly(buildClosure:  {
            $0.setTypeId(6) {
                (interpreter, blocklyCore, i) in
                return 1
            }
            $0.setOutput(.Boolean)
            $0.appendDummyInput()
                .appendField("true")
            $0.setPreviousStatement(false)
        })
    }
    
    public static func createFalseBlock() -> Blockly {
        return Blockly(buildClosure:  {
            $0.setTypeId(7) {
                (interpreter, blocklyCore, i) in
                return 0
            }
            $0.setOutput(.Boolean)
            $0.appendDummyInput()
                .appendField("false")
            $0.setPreviousStatement(false)
        })
    }
    
    public static func createIfThenElseBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.appendValueInput()
                .appendField("if")
                .setCheck(.Boolean)
            $0.appendStatementInput()
                .appendField("then")
            $0.appendStatementInput()
                .appendField("else")
            $0.setTypeId(9) {
                (interpreter, blocklyCore, i) in
                if let index = blocklyCore.inputConnections[0].targetConnection?.sourceBlock.typeId,
                    closure = BlocklyInterpreter.closureMap[index] {
                        /** If condition exists */
                        if closure(interpreter, blocklyCore, i) == 1 {
                            /** If condition returns true */
                            if let nextBlocklyCore = blocklyCore.inputConnections[1].targetConnection?.sourceBlock {
                                /** if then clause exists, execute then clause */
                                interpreter.proceedToSpecificBlock(nextBlocklyCore, i)
                            } else {
                                /** if then clause does not exist, execute next block */
                                interpreter.proceedToNextBlock(blocklyCore, i)
                            }
                        } else {
                            /** If condition return false */
                            if let nextBlocklyCore = blocklyCore.inputConnections[2].targetConnection?.sourceBlock {
                                /** if else clause exists, execute else cluase */
                                interpreter.proceedToSpecificBlock(nextBlocklyCore, i)
                            } else {
                                /** if else clause does not exist, execute next block */
                                interpreter.proceedToNextBlock(blocklyCore, i)
                            }
                        }
                } else {
                    /** If condition cannot be found, exit with error code */
                    interpreter.exit(1)
                }
                return -1
            }
        })
    }
    
    public static func createRepeatDoBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(10)
            $0.appendValueInput()
                .appendField("repeat")
                .setCheck(.Integer)
            $0.appendStatementInput()
                .appendField("do")
        })
     }
    
    public static func createStartBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(11)
            $0.appendDummyInput()
                .appendField("Start")
            $0.deletable = false
            $0.setPreviousStatement(false)
        })
      }
    
    public static func createNumberBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(12)
            $0.setOutput(.Integer)
            $0.setPreviousStatement(false)
            $0.appendDummyInput()
                .appendFieldTextInput(.Integer)
                .appendField("times")
        })
    }
    
    public static func createEndBlock() -> Blockly {
        return Blockly(buildClosure: {
            $0.setTypeId(13)
            $0.setNextStatement(false)
            $0.appendDummyInput()
                .appendField("End")
        })
    }
    
}
