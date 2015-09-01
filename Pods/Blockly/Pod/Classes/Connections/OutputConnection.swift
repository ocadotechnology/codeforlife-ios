//
//  OutputConnection.swift
//  Blockly
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class OutputConnection: Connection {
    
    public var returnType: ReturnType
    public let type: ConnectionType
    unowned public var sourceBlock: BlocklyCore
    
    public weak var targetConnection: Connection? {
        willSet {
            if targetConnection != nil {
                Workspace.topBlocks.append(sourceBlock)
            }
        }
        didSet {
            if targetConnection != nil {
                Workspace.topBlocks.remove(sourceBlock)
            }
        }
    }
    
    init(_ sourceBlock: BlocklyCore, _ returnType: ReturnType) {
        self.sourceBlock = sourceBlock
        self.returnType = returnType
        self.type = .OutputValue
    }
    
    public func connect(otherConnection: Connection?) {
        
        var oldTargetConnection: Connection?
        var orphanConnection: Connection?
        
        if let targetConnection = targetConnection,
            otherConnection = otherConnection where targetConnection == otherConnection {
                /** No change */
        } else {
            /** Change */
            
            if targetConnection != nil {
                /** I already have a connection */
                /** Detach from the original connection */
                oldTargetConnection = targetConnection
                targetConnection?.targetConnection = nil
                targetConnection = nil
            }
            
            if otherConnection?.targetConnection != nil {
                /** otherConnection is already connected to another connection */
                /** detach otherConnection from its original connection */
                orphanConnection = otherConnection?.targetConnection
                otherConnection?.targetConnection?.targetConnection = nil
                otherConnection?.targetConnection = nil
            }
            
            /** Attach otherconnection to myself */
            targetConnection = otherConnection
            otherConnection?.targetConnection = self
        }
        sourceBlock.blockly?.outputTargetConnectionDidChange(oldTargetConnection, orphanConnection: orphanConnection)
    }
    
    public func matchSearchCondition(otherConnection: Connection) -> Bool {
        return  sourceBlock.blockly != otherConnection.sourceBlock.blockly &&
                type == otherConnection.type.oppositeType &&
                (otherConnection is InputValueConnection &&
                    ((otherConnection as! InputValueConnection).returnType == nil ||
                    (otherConnection as! InputValueConnection).returnType == returnType))
        
    }
}