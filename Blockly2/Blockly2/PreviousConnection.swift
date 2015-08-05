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
        // Todo
    }
    
}