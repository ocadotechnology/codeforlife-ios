//
//  BlocklyDelegateExtension.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import AVFoundation
import Foundation

/*
    To avoid having too many lines of code in the same file, all functions related to the `BlockluUIDelegate` reside
    in this extension
 */

extension UIBlocklyView {
    
    func inputDidChange() {
        render()
    }
    
    func nextConnectionDidChange() {
        self.nextConnectionPoint = blockly.nextConnection != nil ? NextConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    func previousConnectionDidChange() {
        self.previousConnectionPoint = blockly.previousConnection != nil ? PreviousConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    func outputConnectionDidChange() {
        self.outputConnectionPoint = blockly.outputConnection != nil ? OutputConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    func outputTargetConnectionDidChange(oldTargetConnection: Connection?, orphanConnection: Connection?, newTargetConnection: Connection?) {
        
        render()
        newTargetConnection?.sourceBlockly.blocklyView?.render()
        oldTargetConnection?.sourceBlockly.blocklyView?.render()
        orphanConnection?.sourceBlockly.blocklyView?.bump()
        
        if let newOutputTargetConnection = blockly.outputConnection?.targetConnection as? InputConnection {
            UIView.animateWithDuration(ConnectionSnapDuration, animations: {
                [unowned self, unowned newOutputTargetConnection] in
                if let targetConnectionPoint = self.findInputByInputConnection(newOutputTargetConnection)?.connectionPoint {
                    self.outputConnectionPoint?.position = targetConnectionPoint.position
                    self.outputConnectionPoint?.updateSourceBlockCenter()
                }
            }, completion: { ( _ ) in
                newOutputTargetConnection.sourceBlockly.blocklyView?.render()
                
            })
        }
        viewController?.delegate?.blocklyDidChange()
    }
    
    func previousTargetConnectionDidChange(oldTargetConnection: Connection?, orphanConnection: Connection?, newTargetConnection: Connection?) {
        
        render()
        newTargetConnection?.sourceBlockly.blocklyView?.render()
        oldTargetConnection?.sourceBlockly.blocklyView?.render()
        if orphanConnection?.targetConnection == nil {
            orphanConnection?.sourceBlockly.blocklyView?.bump()
        }
        
        UIView.animateWithDuration(ConnectionSnapDuration, animations: {
            [unowned self] in
            if let newTargetConnection = newTargetConnection as? InputConnection,
                    targetConnectionPoint = newTargetConnection.sourceBlockly.blocklyView?.findInputByInputConnection(newTargetConnection)?.connectionPoint {
                self.previousConnectionPoint?.position = targetConnectionPoint.position
            } else if let newTargetConnectionPoint = self.blockly.previousConnection?.targetConnection?.sourceBlockly.blocklyView?.nextConnectionPoint {
                self.previousConnectionPoint?.position = newTargetConnectionPoint.position
            }
            self.previousConnectionPoint?.updateSourceBlockCenter()
            }, completion: { [unowned self] ( _ ) in
                self.blockly.parentBlockly?.blocklyView?.render()
            })
    }
    
    func nextTargetConnectionDidChange(newTargetConnection: Connection?) {
        render()
        newTargetConnection?.sourceBlockly.blocklyView?.render()
        if let nextConnectionPoint = self.nextConnectionPoint {
            UIView.animateWithDuration(ConnectionSnapDuration, animations: {
                [unowned nextConnectionPoint] in
                let targetConnectionPoint = nextConnectionPoint.connection.targetConnection?.sourceBlockly.blocklyView?.previousConnectionPoint
                targetConnectionPoint?.position = nextConnectionPoint.position
                targetConnectionPoint?.updateSourceBlockCenter()
                })
        }
        viewController?.delegate?.blocklyDidChange()
    }
    
}