//
//  Connection.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

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
}

public class Connection {
    
    let position: CGPoint
    let type: ConnectionType
    let sourceBlock: Blockly
    
    init(_ sourceBlock: Blockly, _ type: ConnectionType, _ position: CGPoint) {
        self.sourceBlock = sourceBlock
        self.type = type
        self.position = position
    }
    
    func findClosestConnection(searchRadius: CGFloat) -> Connection? {
        var closest: Connection?
        if let subviews = sourceBlock.superview?.subviews {
            for view in subviews {
                if let otherBlockly = view as? Blockly where otherBlockly != sourceBlock {
                    for otherConnection in otherBlockly.connections {
                        if (otherConnection.type.oppositeType == self.type)
                            && (distanceBetween(self.position, otherConnection.position) <= searchRadius) {
                                closest = otherConnection
                        }
                    }
                }
            }
        }
        return closest
    }
    
}