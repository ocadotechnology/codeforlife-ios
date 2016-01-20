//
//  Connection.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class Connection {
    
    public unowned var sourceBlockly: Blockly
    public weak var targetConnection: Connection?
    
    public func connect(otherConnection: Connection?) {}
    public func matchSearchCondition(otherConnection: Connection) -> Bool {return false}
    
    public init(sourceBlockly: Blockly) {
        self.sourceBlockly = sourceBlockly
    }
    
    public func detachConnection() -> Connection? {
        let oldTargetConnection = targetConnection
        targetConnection?.targetConnection = nil
        targetConnection = nil
        return oldTargetConnection
    }
    
    func appendConnection(otherConnection: Connection?) {
        let lastConnection = sourceBlockly.lastBlockly.nextConnection
        lastConnection?.targetConnection = otherConnection
        otherConnection?.targetConnection = lastConnection
    }
    
    func hasNoTargetOrAlreadyConnectedTo(otherConnection: Connection) -> Bool {
        return (targetConnection == nil || targetConnection === otherConnection)
    }
    
    func sameBlocklyCoreAs(otherConnection: Connection?) -> Bool {
        return sourceBlockly === otherConnection?.sourceBlockly
    }
    
}
