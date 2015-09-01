//
//  PreviousConnection.swift
//  Blockly
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class PreviousConnection: Connection {
    
    public let type: ConnectionType
    public let sourceBlock: BlocklyCore
    public weak var targetConnection: Connection? {
        willSet {
            if targetConnection != nil {
                Workspace.topBlocks.append(sourceBlock)
            }
        }
        didSet {
            if targetConnection != nil {
                Workspace.topBlocks.remove(sourceBlock)
            }
        }
    }
    
    init(_ sourceBlock: BlocklyCore) {
        self.sourceBlock = sourceBlock
        self.type = .PreviousStatement
    }
    
    public func connect(otherConnection: Connection?) {
        
        var oldTargetConnection: Connection?
        var orphanConnection: Connection?
        
        if let targetConnection = targetConnection,
            otherConnection = otherConnection where targetConnection == otherConnection {
                /** No Change in Previous Blockly */
                
        } else {
            
            /** Detach the original previous blockly if there exists one */
            oldTargetConnection = targetConnection
            targetConnection?.targetConnection = nil
            targetConnection = nil
            
            if otherConnection?.targetConnection != nil {
                
                /** otherBlockly Already have a next blockly */
                orphanConnection = otherConnection?.targetConnection
                
                /** Detach the orginal next blockly of otherBlockly */
                orphanConnection?.targetConnection = nil
                otherConnection?.targetConnection = nil
                
                /** Attach me to the next blockly of otherBlockly */
                otherConnection?.targetConnection = self
                targetConnection = otherConnection
                
                if let lastConnection = sourceBlock.lastBlocklyCore.nextConnection {
                    /** Attach the orphan block back to my tail */
                    lastConnection.targetConnection = orphanConnection
                    orphanConnection?.targetConnection = lastConnection
                }
                
            } else {
                /** Attach to the previous blockly */
                targetConnection = otherConnection
                otherConnection?.targetConnection = self
            }
        }
        sourceBlock.blockly?.previousTargetConnectionDidChange(oldTargetConnection, orphanConnection: orphanConnection, newTargetConnection: otherConnection)
    }
    
    public func matchSearchCondition(otherConnection: Connection) -> Bool {
        return  sourceBlock.blockly! != otherConnection.sourceBlock.blockly! &&
                (otherConnection.type == ConnectionType.NextStatement ||
                    otherConnection.type == ConnectionType.InputValue &&
                    (otherConnection as! InputConnection).inputType == InputType.Statement)
    }
}