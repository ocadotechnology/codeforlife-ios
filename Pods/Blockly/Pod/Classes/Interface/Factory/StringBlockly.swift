//
//  StringBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
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
    
}
