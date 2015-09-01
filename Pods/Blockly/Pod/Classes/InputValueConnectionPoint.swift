//
//  InputValueConnectionPoint.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

class InputValueConnectionPoint : InputConnectionPoint {
    
    override var position: CGPoint {
        get {
            let offset = CGPointMake(sourceInput.frame.width, sourceInput.frame.height/2)
            return sourceInput.sourceBlock.frame.origin + sourceInput.frame.origin + offset
        }
        set {}
    }
    
    init(_ sourceInput: Input) {
        super.init(sourceInput, InputValueConnection(sourceInput.sourceBlock.blocklyCore))
    }
    
    override func updateTargetConnectionPosition() {
        let targetConnectionPoint = connection.targetConnection?.sourceBlock.blockly?.outputConnectionPoint
        targetConnectionPoint?.position = position
        targetConnectionPoint?.updateSourceBlockCenter()
    }
    
}
