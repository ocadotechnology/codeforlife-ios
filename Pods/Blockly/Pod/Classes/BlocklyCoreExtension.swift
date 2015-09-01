//
//  BlocklyCoreExtension.swift
//  Pods
//
//  Created by Joey Chan on 01/09/2015.
//
//

import Foundation

public extension BlocklyCore {
    
    public unowned var lastBlocklyCore: BlocklyCore {
        return nextBlocklyCore?.lastBlocklyCore ?? self
    }
    
    public weak var nextBlocklyCore: BlocklyCore? {
        return nextConnection?.targetConnection?.sourceBlock
    }
    
    public weak var previousBlocklyCore: BlocklyCore? {
        return previousConnection?.targetConnection?.sourceBlock
    }
    
    public weak var outputBlocklyCore: BlocklyCore? {
        return outputConnection?.targetConnection?.sourceBlock
    }
    
    public weak var parentBlocklyCore: BlocklyCore? {
        if let previousTargetConnection = previousConnection?.targetConnection {
            return previousTargetConnection is InputStatementConnection ?
                previousTargetConnection.sourceBlock :
                previousTargetConnection.sourceBlock.parentBlocklyCore
        }
        return nil
    }
    
    public unowned var topBlocklyCore: BlocklyCore {
        if let previousTargetConnection = previousConnection?.targetConnection {
            if let targetConnection = previousTargetConnection as? InputStatementConnection {
                return self
            }
            return previousTargetConnection.sourceBlock.topBlocklyCore
        }
        return self
    }
    
}