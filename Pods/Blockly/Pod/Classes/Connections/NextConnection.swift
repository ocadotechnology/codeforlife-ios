//
//  NextConnection.swift
//  Blockly
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class NextConnection: Connection {
    
    public unowned let sourceBlock: BlocklyCore
    public let type: ConnectionType
    public weak var targetConnection: Connection?
    
    init(_ sourceBlock: BlocklyCore) {
        self.sourceBlock = sourceBlock
        self.type = .NextStatement
    }
    
    public func connect(otherConnection: Connection?)
    {
        if let targetConnection = targetConnection,
            otherConnection = otherConnection where targetConnection == otherConnection {
                /** No change in next blockly */
                
        } else {
            /** There are changes in next blockly */
            
            if let previousConnection = sourceBlock.previousConnection,
                previousTarget = previousConnection.targetConnection,
                otherConnection = otherConnection where previousTarget == otherConnection {
                    /** otherBlockly was my previous blockly */
                    
                    /** Detach the previous link */
                    otherConnection.targetConnection = nil
                    previousConnection.targetConnection = nil
                    
                    /** Attach otherBlockly as my next blockly */
                    otherConnection.targetConnection = self
                    targetConnection = otherConnection
                    
            } else if otherConnection?.targetConnection != nil {
                /**
                otherBlockly already has a previous Blockly
                Do nothing
                */
            } else {
                /** Attach to the next blockly */
                targetConnection?.targetConnection = nil
                targetConnection = otherConnection
                otherConnection?.targetConnection = self
            }
        }
        sourceBlock.blockly?.nextTargetConnectionDidChange()
    }
    
    public func matchSearchCondition(otherConnection: Connection) -> Bool
    {
        return  !sameBlocklyCore(self, otherConnection) &&
                validConnectionTypePair(self, otherConnection) &&
                (otherConnection.targetConnection == nil ||
                    otherConnection === targetConnection)
    }
    
}

func sameBlocklyCore(lhs: Connection, rhs: Connection) -> Bool {
    return lhs.sourceBlock === rhs.sourceBlock
}

func validConnectionTypePair(lhs: Connection, rhs: Connection) -> Bool {
    return lhs.type == rhs.type.oppositeType
}