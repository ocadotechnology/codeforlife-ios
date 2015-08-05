//
//  Connection.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class Connection {
    
    var position: CGPoint
    let positionOffset: CGPoint
    let type: ConnectionType
    let sourceBlock: Blockly
    let searchRadius: CGFloat = 20
    var targetConnection: Connection?
    var delegate: ConnectionDelegate?
    
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
        delegate!.updateSourceBlockCenter()
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
    
    final func distanceTo(otherConnection: Connection) -> CGFloat {
        return distanceBetween(self, otherConnection)
    }
    
    func connect(otherConnection: Connection) {
        delegate!.connect(otherConnection)
    }
    
    /**
        Another Connection must be already connected or fulfill all the following search conditions to be validated
        
        1. Not sharing the same blockly
        
        2. Opposite type of each other
        
        3. Within search range
    
        4. Connection cannot be inserted between two blocklys as the previous blockly of the latter one
    
        :param: otherConnection the connection to be checked against the conditions
        
        :returns: true if otherConnection fulfills all the conditions, false otherwise
     */
    
    private func matchSearchCondition(otherConnection: Connection) -> Bool {
        return delegate!.matchSearchCondition(otherConnection)
    }
    
}

/**
    Equality check for Connection
 
    :param: lhs First connection to be compared to

    :param: rhs Second connection to be compared to, can be optional

    :returns: true if they share the same sourceBlock and type, false otherwise
 */
func ==(lhs: Connection, rhs: Connection) -> Bool {
    return lhs.type == rhs.type && lhs.sourceBlock == rhs.sourceBlock
}
