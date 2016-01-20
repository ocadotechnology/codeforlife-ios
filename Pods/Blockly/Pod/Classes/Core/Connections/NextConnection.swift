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
    
    override public func connect(otherConnection: Connection?) {
        if otherBlocklyIsPreviousBlockly(otherConnection) {
            sourceBlockly.previousConnection?.detachConnection()
        }
        self.detachConnection()
        self.targetConnection = otherConnection
        otherConnection?.targetConnection = self
        sourceBlockly.blocklyView?.nextTargetConnectionDidChange(otherConnection)
    }
    
    override public func matchSearchCondition(otherConnection: Connection) -> Bool {
        return  !sameBlocklyCoreAs(otherConnection) &&
                isValidPairWith(otherConnection) &&
                otherConnection.hasNoTargetOrAlreadyConnectedTo(self)
    }
    
    private func otherBlocklyIsPreviousBlockly(otherConnection: Connection?) -> Bool {
        if let previousConnection = sourceBlockly.previousConnection,
            previousTarget = previousConnection.targetConnection,
            otherNextConnection = otherConnection?.sourceBlockly.nextConnection where previousTarget === otherNextConnection {
                return true
        }
        return false
    }
    
    private func isValidPairWith(otherConnection: Connection) -> Bool {
        return otherConnection is PreviousConnection
    }
    
}