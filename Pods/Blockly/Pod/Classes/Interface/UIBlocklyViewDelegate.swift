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

extension UIBlocklyView : BlocklyUIDelegate {
    
    public func inputDidChange() {
        render()
    }
    
    public func nextConnectionDidChange() {
        self.nextConnectionPoint = blockly.nextConnection != nil ? NextConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    public func previousConnectionDidChange() {
        self.previousConnectionPoint = blockly.previousConnection != nil ? PreviousConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    public func outputConnectionDidChange() {
        self.outputConnectionPoint = blockly.outputConnection != nil ? OutputConnectionPoint(self) : nil
        viewController?.delegate?.blocklyDidChange()
    }
    
    public func outputTargetConnectionDidChange(oldTargetConnection: Connection?, orphanConnection: Connection?, newTargetConnection: Connection?) {
        
        render()
        (newTargetConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.render()
        (oldTargetConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.render()
        (orphanConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.bump()
        
        if let newOutputTargetConnection = blockly.outputConnection?.targetConnection as? InputConnection {
            UIView.animateWithDuration(ConnectionSnapDuration, animations: {
                [unowned self, unowned newOutputTargetConnection] in
                if let targetConnectionPoint = self.findInputByInputConnection(newOutputTargetConnection)?.connectionPoint {
                    self.outputConnectionPoint?.position = targetConnectionPoint.position
                    self.outputConnectionPoint?.updateSourceBlockCenter()
                }
            }, completion: { ( _ ) in
                (newOutputTargetConnection.sourceBlockly.blocklyView as? UIBlocklyView)?.render()
                
            })
        }
        viewController?.delegate?.blocklyDidChange()
    }
    
    public func previousTargetConnectionDidChange(oldTargetConnection: Connection?, orphanConnection: Connection?, newTargetConnection: Connection?) {
        
        render()
        (newTargetConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.render()
        (oldTargetConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.render()
        if orphanConnection?.targetConnection == nil {
            (orphanConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.bump()
        }
        
        UIView.animateWithDuration(ConnectionSnapDuration, animations: {
            [unowned self] in
            if let newTargetConnection = newTargetConnection as? InputConnection,
                    targetBlocklyView =  newTargetConnection.sourceBlockly.blocklyView as? UIBlocklyView,
                    targetConnectionPoint = targetBlocklyView.findInputByInputConnection(newTargetConnection)?.connectionPoint {
                self.previousConnectionPoint?.position = targetConnectionPoint.position
            } else if let newTargetConnectionPoint = (self.blockly.previousConnection?.targetConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.nextConnectionPoint {
                self.previousConnectionPoint?.position = newTargetConnectionPoint.position
            }
            self.previousConnectionPoint?.updateSourceBlockCenter()
            }, completion: { [unowned self] ( _ ) in
                (self.blockly.parentBlockly?.blocklyView as? UIBlocklyView)?.render()
            })
    }
    
    public func nextTargetConnectionDidChange(newTargetConnection: Connection?) {
        render()
        (newTargetConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.render()
        if let nextConnectionPoint = self.nextConnectionPoint {
            UIView.animateWithDuration(ConnectionSnapDuration, animations: {
                [unowned nextConnectionPoint] in
                let targetConnectionPoint = (nextConnectionPoint.connection.targetConnection?.sourceBlockly.blocklyView as? UIBlocklyView)?.previousConnectionPoint
                targetConnectionPoint?.position = nextConnectionPoint.position
                targetConnectionPoint?.updateSourceBlockCenter()
                })
        }
        viewController?.delegate?.blocklyDidChange()
    }
    
}