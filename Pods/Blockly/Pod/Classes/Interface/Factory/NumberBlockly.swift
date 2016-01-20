//
//  NumberBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
    public static func createNumberBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.Number) {
                (interpreter, blockly) in
                if let result = Int(blockly.args[0]) {
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
    
}
