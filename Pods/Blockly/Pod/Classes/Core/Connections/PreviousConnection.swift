//
//  PreviousConnection.swift
//  Blockly
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class PreviousConnection: Connection {

    override public weak var targetConnection: Connection? {
        willSet {
            if newValue == nil {
                Workspace.getInstance().topBlocks.appendIfNotNil(sourceBlockly)
            } else {
                Workspace.getInstance().topBlocks.remove(sourceBlockly)
            }
        }
    }
    
    override public func connect(otherConnection: Connection?) {
        let oldTargetConnection = detachConnection()
        let orphanConnection = otherConnection?.detachConnection()
        self.targetConnection = otherConnection
        otherConnection?.targetConnection = self
        self.appendConnection(orphanConnection)
        sourceBlockly.blocklyView?.previousTargetConnectionDidChange(oldTargetConnection, orphanConnection: orphanConnection, newTargetConnection: otherConnection)
    }
    
    override public func matchSearchCondition(otherConnection: Connection) -> Bool {
        return  !sameBlocklyCoreAs(otherConnection) && isValidPairWith(otherConnection)
    }
    
    private func isValidPairWith(otherConnection: Connection) -> Bool {
        return otherConnection is NextConnection || otherConnection is InputStatementConnection
    }
    
}