//
//  TrueBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
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
    
}