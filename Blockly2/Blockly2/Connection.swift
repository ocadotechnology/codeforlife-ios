//
//  Connection.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

enum ConnectionType {
    case NextConnection
    case PreviousConnection
    
    var oppositeType: ConnectionType {
        switch self {
        case .NextConnection: return .PreviousConnection
        case .PreviousConnection: return .NextConnection
        }
    }
    
    var isAggressiveType: Bool {
        return (self == NextConnection)
    }
}

public class Connection {
    
    var position: CGPoint
    let positionOffset: CGPoint
    let type: ConnectionType
    let sourceBlock: Blockly
    var targetConnection: Connection? {
        willSet {
            if type.isAggressiveType {
                targetConnection?.targetConnection = nil
            }
        }
        didSet {
            if type.isAggressiveType {
                targetConnection?.targetConnection = self
            }
        }
    }
    
    init(_ sourceBlock: Blockly, _ type: ConnectionType, _ position: CGPoint) {
        self.sourceBlock = sourceBlock
        self.type = type
        self.position = position
        self.positionOffset = sourceBlock.center - position
    }
    
    func updateSourceBlockCenter() {
        self.sourceBlock.center = position + positionOffset
    }
    
    /**
     Find the Closest suitable connection within search radius including/excluding connected connection
     @param searchRadius radius in CGFloat to seach for the connection
     @param includeConnected true if result should include connected connections, false otherwise
     @return connection in the closest distance, nil if there does not exist one
     */
    func findClosestConnection(searchRadius: CGFloat, _ includeConnected: Bool) -> Connection? {
        var closest: Connection?
        if let subviews = sourceBlock.superview?.subviews {
            for view in subviews {
                if let otherBlockly = view as? Blockly where otherBlockly != sourceBlock {
                    
                    /** Search through all the connection in all the blocklys */
                    for otherConnection in otherBlockly.connections {
                        if (otherConnection.type.oppositeType == self.type)
                            && (distanceBetween(self.position, otherConnection.position) <= searchRadius) {
                            
                            if let targetConnection = targetConnection where
                                otherConnection == targetConnection && !includeConnected {
                                /**
                                 otherConenction is already connected
                                 Do nothing
                                 */
                            } else if closest == nil {
                                /** This is the first acceptable result */
                                closest = otherConnection
                            } else if let currentClosest = closest where
                            distanceBetween(self.position, otherConnection.position) < distanceBetween(self.position, currentClosest.position) {
                                /** There is a new connection closer to the current resull */
                                closest = otherConnection
                            }
                        }
                    }
                }
            }
        }
        return closest
    }
    
}

/**
 Equality check for Connection
 @param lhs First connection to be compared to
 @param rhs Second connection to be compared to
 @return true if they share the same sourceBlock and type, false otherwise
 */
func ==(lhs: Connection, rhs: Connection) -> Bool {
    return lhs.type == rhs.type && lhs.sourceBlock == rhs.sourceBlock
}