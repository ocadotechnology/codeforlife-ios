//
//  PreviousConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class PreviousConnection: Connection {
    
    init(_ sourceBlock: Blockly) {
        let position = sourceBlock.frame.origin + PreviousConnectionOffset
        super.init(sourceBlock, .PreviousConnection, position)
        self.delegate = PreviousConnectionDelegate(self)
    }
}

public class PreviousConnectionDelegate: ConnectionDelegate {
    
    unowned var connection: PreviousConnection
    
    init(_ connection: PreviousConnection) {
        self.connection = connection
    }
    
    func updateSourceBlockCenter() {
        connection.sourceBlock.frame.origin = connection.position - PreviousConnectionOffset
        connection.sourceBlock.center = connection.sourceBlock.frame.origin + CGPointMake(connection.sourceBlock.frame.width/2, connection.sourceBlock.frame.height/2)
    }
    
    func matchSearchCondition(otherConnection: Connection) -> Bool {
        return
        /* 1 */ connection.sourceBlock != otherConnection.sourceBlock &&
        /* 2 */ connection.distanceTo(otherConnection) <= SearchRadius &&
        /* 3 */ (otherConnection.type == ConnectionType.NextConnection ||
                    otherConnection.type == ConnectionType.InputValue &&
                    (otherConnection as! InputConnection).inputType == InputType.Statement)
    }
    
    func connect(otherConnection: Connection?) {
        if let targetConnection = connection.targetConnection,
                otherConnection = otherConnection where targetConnection == otherConnection {
            /** No Change in Previous Blockly */
            
        } else {
            
            /** Detach the original previous blockly if there exists one */
            let oldPreviousConnection = connection.targetConnection
            connection.targetConnection?.targetConnection = nil
            oldPreviousConnection?.sourceBlock.parentBlockly?.render()
            connection.targetConnection = nil
            
            if otherConnection?.targetConnection != nil {
                
                /** otherBlockly Already have a next blockly */
                let orphanConnection = otherConnection?.targetConnection
                
                /** Detach the orginal next blockly of otherBlockly */
                orphanConnection?.targetConnection = nil
                otherConnection?.targetConnection = nil
                
                /** Attach me to the next blockly of otherBlockly */
                otherConnection?.targetConnection = connection
                connection.targetConnection = otherConnection
                
                if let lastConnection = connection.sourceBlock.lastBlockly.nextConnection {
                    /** Attach the orphan block back to my tail */
                    lastConnection.targetConnection = orphanConnection
                    orphanConnection?.targetConnection = lastConnection
                } else {
                    /** Next Statement is not allowed in the last blockly */
                    orphanConnection?.sourceBlock.bump()
                }
                
            } else {
                /** Attach to the previous blockly */
                connection.targetConnection = otherConnection
                otherConnection?.targetConnection = connection
            }
            
        }
        /** Update position after connection */
        if let otherConnection = otherConnection {
            println(connection.sourceBlock.parentBlockly)
            connection.sourceBlock.parentBlockly?.render()
            UIView.animateWithDuration(ConnectionSnapDuration, animations: {
                [unowned connection] in
                connection.position = otherConnection.position
                connection.updateSourceBlockCenter()
            })
        }
    }
    
}