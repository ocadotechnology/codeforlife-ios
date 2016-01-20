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
    
    public var returnType: Int
    
    override public weak var targetConnection: Connection? {
        willSet { Workspace.getInstance().topBlocks.appendIfNotNil(sourceBlockly) }
        didSet {
            Workspace.getInstance().topBlocks.remove(sourceBlockly)
            if targetConnection?.targetConnection !== self {
                targetConnection?.targetConnection = self
            }
        }
    }
    
    public init(_ sourceBlock: Blockly, _ returnType: Int) {
        self.returnType = returnType
        super.init(sourceBlockly: sourceBlock)
    }
    
    override public func connect(otherConnection: Connection?) {
        let oldTargetConnection = detachConnection()
        let orphanConnection = otherConnection?.detachConnection()
        targetConnection = otherConnection
        otherConnection?.targetConnection = self
        sourceBlockly.blocklyView?.outputTargetConnectionDidChange(oldTargetConnection, orphanConnection: orphanConnection, newTargetConnection: otherConnection)
    }
    
    override public func matchSearchCondition(otherConnection: Connection) -> Bool {
        return  !sameBlocklyCoreAs(otherConnection) &&
                isValidPairWith(otherConnection) &&
                sameReturnTypeAs(otherConnection)
    }
    
    private func sameReturnTypeAs(otherConnection: Connection) -> Bool {
        if let otherConnection = otherConnection as? InputValueConnection {
            return otherConnection.returnType & returnType != 0
        }
        return false
    }
    
    private func isValidPairWith(otherConnection: Connection) -> Bool {
        return otherConnection is InputValueConnection
    }
}