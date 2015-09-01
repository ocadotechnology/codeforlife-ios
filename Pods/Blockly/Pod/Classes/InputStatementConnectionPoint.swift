//
//  InputStatementConnectionPoint.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

class InputStatementConnectionPoint: InputConnectionPoint {
    
    override var position: CGPoint {
        get {
            let offset = CGPointMake(sourceInput.sourceBlock.frame.width*3/4, TabSize.height)
            return sourceInput.sourceBlock.frame.origin + CGPointMake(0,sourceInput.frame.origin.y) + offset
        }
        set {}
    }
    
    init(_ sourceInput: Input) {
        super.init(sourceInput, InputStatementConnection(sourceInput.sourceBlock.blocklyCore))
    }
    
    override func updateTargetConnectionPosition() {
        let targetConnectionPoint = (connection as? InputConnection)?.targetConnection?.sourceBlock.blockly?.previousConnectionPoint
        targetConnectionPoint?.position = position
        targetConnectionPoint?.updateSourceBlockCenter()
    }
    
}