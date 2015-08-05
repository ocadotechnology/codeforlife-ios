//
//  NextConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class NextConnection: Connection {
    
    init(_ sourceBlock: Blockly, _ position: CGPoint) {
        super.init(sourceBlock, .NextConnection, position)
        self.delegate = NextConnectionDelegate(self)
    }
    
}

public class NextConnectionDelegate: ConnectionDelegate {
    
    unowned var connection: NextConnection
    
    init(_ connection: NextConnection) {
        self.connection = connection
    }
    
    func updateSourceBlockCenter() {
        connection.sourceBlock.center = connection.position + connection.positionOffset
    }
    
    func connect(otherConnection: Connection?) {
        // TODO
    }
    
    func matchSearchCondition(otherConnection: Connection) -> Bool {
        return
        /* 1 */ connection.sourceBlock != otherConnection.sourceBlock &&
        /* 2 */ connection.type == otherConnection.type.oppositeType &&
        /* 3 */ connection.distanceTo(otherConnection) <= connection.searchRadius &&
        /* 4 */ !(otherConnection.type == .PreviousConnection &&
                    otherConnection.targetConnection != nil &&
                    connection.targetConnection != nil &&
                    !(otherConnection == connection.targetConnection!))
    }
}