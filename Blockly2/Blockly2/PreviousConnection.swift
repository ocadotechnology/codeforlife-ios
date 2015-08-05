//
//  PreviousConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class PreviousConnection: Connection {
    
    init(_ sourceBlock: Blockly, _ position: CGPoint) {
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
        let offset = CGPointMake(0, connection.sourceBlock.frame.height/2)
        connection.sourceBlock.center = connection.position + offset
    }
    
    func matchSearchCondition(otherConnection: Connection) -> Bool {
        return
        /* 1 */ connection.sourceBlock != otherConnection.sourceBlock &&
        /* 2 */ connection.type == otherConnection.type.oppositeType &&
        /* 3 */ connection.distanceTo(otherConnection) <= connection.searchRadius
    }
    
    func connect(otherConnection: Connection?) {
        if let targetConnection = connection.targetConnection,
                otherConnection = otherConnection where targetConnection == otherConnection {
            /** No Change in Previous Blockly */
            
        } else {
            
            /** Detach the original previous blockly if there exists one */
            connection.targetConnection?.targetConnection = nil
            connection.targetConnection = nil
            
            if otherConnection?.targetConnection != nil {
                
                /** otherBlockly Already have a next blockly */
                let orphanConnection = otherConnection?.targetConnection
                
                /** Detach the orginal next blockly of otherBlockly */
                otherConnection?.targetConnection = nil
                orphanConnection?.targetConnection = nil
                
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
            connection.position = otherConnection.position
            connection.updateSourceBlockCenter()
        }
    }
    
}