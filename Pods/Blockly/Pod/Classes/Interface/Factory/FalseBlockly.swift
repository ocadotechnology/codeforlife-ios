//
//  FalseBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
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
    
}
