//
//  PrintBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
    public static func createPrintBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.Print) {
                (interpreter, blockly) in
                if let stringBlock = blockly.inputConnections.first?.targetConnection?.sourceBlockly,
                    content = stringBlock.args.first {
                        if stringBlock.typeId == BlocklyType.String {
                            print(content, terminator: "")
                        } else if stringBlock.typeId == BlocklyType.GetVariable {
                            if let content = interpreter.vars[content] {
                                print(content, terminator: "")
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
    
}
