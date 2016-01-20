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
            let offset = CGPointMake(sourceInput.sourceBlocklyView.frame.width - BlankSize.width, sourceInput.frame.height/2)
            return sourceInput.sourceBlocklyView.frame.origin + sourceInput.frame.origin + offset
        }
        set {}
    }
    
    init(_ sourceInput: Input) {
        super.init(sourceInput, InputValueConnection(sourceInput.sourceBlocklyView.blockly))
    }
    
    override func updateTargetConnectionPosition() {
        let targetConnectionPoint = (connection.targetConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.outputConnectionPoint
        targetConnectionPoint?.position = position
        targetConnectionPoint?.updateSourceBlockCenter()
    }
    
}
