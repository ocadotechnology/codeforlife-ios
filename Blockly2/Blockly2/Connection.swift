//
//  Connection.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

enum ConnectionType: String {
    case InputValue = "InputValue"
    case OutputValue = "OutputValue"
    case NextConnection = "NextConnection"
    case PreviousConnection = "PreviousConnction"
    
    var oppositeType: ConnectionType {
        switch self {
        case .InputValue: return .OutputValue
        case .OutputValue: return .InputValue
        case .NextConnection: return .PreviousConnection
        case .PreviousConnection: return .NextConnection
        }
    }
}

public class NextConnection: Connection {
    
    init(_ sourceBlock: Blockly, _ position: CGPoint) {
        super.init(sourceBlock, .NextConnection, position)
    }
    
}

public class PreviousConnection: Connection {
    
    init(_ sourceBlock: Blockly, _ position: CGPoint) {
        super.init(sourceBlock, .PreviousConnection, position)
    }
}

public class OutputConnection: Connection {
    init(_ sourceBlock: Blockly, _ position: CGPoint) {
        super.init(sourceBlock, .OutputValue, position)
    }
}

public class Connection {
    
    var position: CGPoint
    let positionOffset: CGPoint
    let type: ConnectionType
    let sourceBlock: Blockly
    let searchRadius: CGFloat = 20
    var targetConnection: Connection?
    
    init(_ sourceBlock: Blockly, _ type: ConnectionType, _ position: CGPoint) {
        self.sourceBlock = sourceBlock
        self.type = type
        self.position = position
        self.positionOffset = sourceBlock.center - position
    }
    
    /**
        Update sourceBlock center to follow the change in connection position
        This is done manually to avoid infinite recursion
     */
    func updateSourceBlockCenter() {
        self.sourceBlock.center = position + positionOffset
    }
    
    /**
        Find the Closest suitable connection within search radius including/excluding connected connection
    
        :param: connections list of connections to search through
     
        :param: searchRadius radius in CGFloat to seach for the connection
     
        :param: includeConnected true if result should include connected connections, false otherwise
     
        :returns: a tuple of connection in the closest distance, nil if there does not exist one, with the shortestDistance
     */
    func findClosestAvailableConnection(connections: [Connection], _ searchRadius: CGFloat, includeConnected: Bool) -> (Connection, CGFloat)? {
        var closest: Connection?
        var shortestDistance: CGFloat = -1
        for otherConnection in connections {
            if matchSearchCondition(otherConnection) {
                if closest == nil || distanceTo(otherConnection) < shortestDistance {
                    closest = otherConnection
                    shortestDistance = distanceTo(otherConnection)
                }
            }
        }
        return closest != nil ? (closest!, shortestDistance) : nil
    }
    
    func distanceTo(otherConnection: Connection) -> CGFloat {
        return distanceBetween(self, otherConnection)
    }
    
    /**
        Another Connection must be already connected or fulfill all the following search conditions to be validated
        
        1. Not sharing the same blockly
        
        2. Opposite type of each other
        
        3. Within search range
    
        :param: otherConnection the connection to be checked against the conditions
        
        :returns: true if otherConnection fulfills all the conditions, false otherwise
     */
    
    private func matchSearchCondition(otherConnection: Connection) -> Bool {
        return
        /* 1 */ self.sourceBlock != otherConnection.sourceBlock &&
        /* 2 */ otherConnection.type.oppositeType == self.type &&
        /* 3 */ distanceTo(otherConnection) <= searchRadius
    }
    
}

/**
    Equality check for Connection
 
    :param: lhs First connection to be compared to

    :param: rhs Second connection to be compared to

    :returns: true if they share the same sourceBlock and type, false otherwise
 */
func ==(lhs: Connection, rhs: Connection) -> Bool {
        return lhs.type == rhs.type && lhs.sourceBlock == rhs.sourceBlock
}
