//
//  PrintlnBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
    public static func createPrintlnBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.Println) {
                (interpreter, blockly) in
                if let stringBlock = blockly.inputConnections.first?.targetConnection?.sourceBlockly,
                    content = stringBlock.args.first {
                        if stringBlock.typeId == BlocklyType.String {
                            print(content)
                        } else if stringBlock.typeId == BlocklyType.GetVariable {
                            if let content = interpreter.vars[content] {
                                print(content)
                            } else {
                                print("")
                            }
                        }
                } else {
                    print("")
                }
                return interpreter.proceedToNextBlockly(blockly)
            }
            $0.appendInput(.Value)
                .appendField("println")
                .setCheck(ReturnType.String)
        })
    }
    
}
