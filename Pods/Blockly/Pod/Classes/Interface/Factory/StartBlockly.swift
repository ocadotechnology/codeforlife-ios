//
//  StartBlockly.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

extension BlocklyFactory {
    
    public static func createStartBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            $0.setTypeId(BlocklyType.Start)
            $0.appendInput(.Dummy)
                .appendField("Start")
            $0.mode = BlocklyUIMode.All & ~BlocklyUIMode.Deletable
            $0.setPreviousStatement(false)
        })
    }
    
}
