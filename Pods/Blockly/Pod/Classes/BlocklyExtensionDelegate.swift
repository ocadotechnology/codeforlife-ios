//
//  BlocklyDelegateExtension.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

extension Blockly {
    
    func inputDidChange() {
        render()
    }
    
    func nextConnectionDidChange() {
        self.nextConnectionPoint = blocklyCore.nextConnection != nil ? NextConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    func previousConnectionDidChange() {
        self.previousConnectionPoint = blocklyCore.previousConnection != nil ? PreviousConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    func outputConnectionDidChange() {
        self.outputConnectionPoint = blocklyCore.outputConnection != nil ? OutputConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    func outputTargetConnectionDidChange(oldTargetConnection: Connection?, orphanConnection: Connection?) {
        
        oldTargetConnection?.sourceBlock.blockly?.render()
        orphanConnection?.sourceBlock.blockly?.bump()
        
        if let newOutputTargetConnection = blocklyCore.outputConnection?.targetConnection as? InputConnection {
            UIView.animateWithDuration(ConnectionSnapDuration, animations: {
                [unowned self, unowned newOutputTargetConnection] in
                if let targetConnectionPoint = self.outputConnectionPoint?.connection.targetConnection as? InputConnectionPoint {
                    self.outputConnectionPoint?.position = targetConnectionPoint.position
                    self.outputConnectionPoint?.updateSourceBlockCenter()
                }
            }, completion: { ( _ ) in
                newOutputTargetConnection.sourceBlock.blockly?.render()
            })
        }
        viewController?.delegate?.blocklyDidChange()
    }
    
    func previousTargetConnectionDidChange(oldTargetConnection: Connection?, orphanConnection: Connection?, newTargetConnection: Connection?) {
        
        oldTargetConnection?.sourceBlock.blockly?.render()
        if orphanConnection?.targetConnection == nil {
            orphanConnection?.sourceBlock.blockly?.bump()
        }
        
        UIView.animateWithDuration(ConnectionSnapDuration, animations: {
            [unowned self] in
            if let newTargetConnection = newTargetConnection as? InputConnection,
                    targetConnectionPoint = newTargetConnection.sourceBlock.blockly?.findInputByInputConnection(newTargetConnection)?.connectionPoint {
                self.previousConnectionPoint?.position = targetConnectionPoint.position
            } else if let newTargetConnectionPoint = self.blocklyCore.previousConnection?.targetConnection?.sourceBlock.blockly?.nextConnectionPoint {
                self.previousConnectionPoint?.position = newTargetConnectionPoint.position
            }
            self.previousConnectionPoint?.updateSourceBlockCenter()
            }, completion: { [unowned self] ( _ ) in
                self.blocklyCore.parentBlocklyCore?.blockly?.render()
            })
    }
    
    func nextTargetConnectionDidChange() {
        if let nextConnectionPoint = self.nextConnectionPoint {
            UIView.animateWithDuration(ConnectionSnapDuration, animations: {
                [unowned nextConnectionPoint] in
                let targetConnectionPoint = nextConnectionPoint.connection.targetConnection?.sourceBlock.blockly?.previousConnectionPoint
                targetConnectionPoint?.position = nextConnectionPoint.position
                targetConnectionPoint?.updateSourceBlockCenter()
                })
        }
        viewController?.delegate?.blocklyDidChange()
    }
    
}