//
//  NextConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class NextConnection: Connection {
    
    override var position: CGPoint {
        didSet {
            targetConnection?.position = position
            targetConnection?.updateSourceBlockCenter()
        }
    }
    
    init(_ sourceBlock: Blockly) {
        let position = sourceBlock.frame.origin + CGPointMake(0, sourceBlock.frame.height - TabHeight) + NextConnectionOffset
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
        let frame = connection.sourceBlock.frame
        connection.sourceBlock.frame.origin = connection.position - CGPointMake(0, connection.sourceBlock.frame.height-TabHeight) - NextConnectionOffset
        connection.sourceBlock.center = connection.sourceBlock.frame.origin + CGPointMake(connection.sourceBlock.frame.width/2, connection.sourceBlock.frame.height/2)
    }
    
    func connect(otherConnection: Connection?) {
        if let targetConnection = connection.targetConnection,
                otherConnection = otherConnection where targetConnection == otherConnection {
            /** No change in next blockly */
            
        } else {
            /** There are changes in next blockly */
            
            if let previousConnection = connection.sourceBlock.previousConnection,
                    previousTarget = previousConnection.targetConnection,
                    otherConnection = otherConnection where previousTarget == otherConnection {
                /** otherBlockly was my previous blockly */
                
                /** Detach the previous link */
                otherConnection.targetConnection = nil
                previousConnection.targetConnection = nil
                
                /** Attach otherBlockly as my next blockly */
                otherConnection.targetConnection = connection
                connection.targetConnection = otherConnection
                
            } else if otherConnection?.targetConnection != nil {
                /**
                otherBlockly already has a previous Blockly
                Do nothing
                */
            } else {
                /** Attach to the next blockly */
                connection.targetConnection?.targetConnection = nil
                connection.targetConnection = otherConnection
                otherConnection?.targetConnection = connection
            }
        }
        
        UIView.animateWithDuration(ConnectionSnapDuration, animations: {
            [weak otherConnection, unowned connection] in
            otherConnection?.position = connection.position
            otherConnection?.updateSourceBlockCenter()
        })
    }
    
    func matchSearchCondition(otherConnection: Connection) -> Bool {
        return
        /* 1 */ connection.sourceBlock != otherConnection.sourceBlock &&
        /* 2 */ connection.type == otherConnection.type.oppositeType &&
        /* 3 */ connection.distanceTo(otherConnection) <= SearchRadius &&
        /* 4 */ !(otherConnection.type == .PreviousConnection &&
                    otherConnection.targetConnection != nil &&
                    connection.targetConnection != nil &&
                    !(otherConnection == connection.targetConnection!))
    }
}