//
//  OutputConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class OutputConnection: Connection {
    init(_ sourceBlock: Blockly, _ position: CGPoint) {
        super.init(sourceBlock, .OutputValue, position)
        self.delegate = OutputConnectionDelegate(self)
    }
}

public class OutputConnectionDelegate: ConnectionDelegate {
    
    unowned var connection: OutputConnection
    
    init(_ connection: OutputConnection) {
        self.connection = connection
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
                /** No change */
        } else {
            /** Change */
            
            if connection.targetConnection != nil {
                /** I already have a connection */
                /** Detach from the original connection */
                connection.targetConnection?.targetConnection = nil
                connection.targetConnection = nil
            }
            
            if otherConnection?.targetConnection != nil {
                /** otherConnection is already connected to another connection */
                /** detach otherConnection from its original connection */
                otherConnection?.targetConnection?.targetConnection = nil
                otherConnection?.targetConnection = nil
            }
            
            /** Attach otherconnection to myself */
            connection.targetConnection = otherConnection
            otherConnection?.targetConnection = connection
        }
        
        /** Snap to Output Blockly */
        if let otherConnection = otherConnection {
            connection.position = otherConnection.position
            connection.updateSourceBlockCenter()
        }
    }
    
    func updateSourceBlockCenter() {
        connection.sourceBlock.center = connection.position + connection.positionOffset
    }
}