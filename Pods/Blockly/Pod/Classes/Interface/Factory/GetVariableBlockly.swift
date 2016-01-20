//
//  GetVariableBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
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
