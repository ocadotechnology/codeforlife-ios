//
//  BlocklyCore.swift
//  Pods
//
//  Created by Joey Chan on 19/08/2015.
//
//

import Foundation

public class Blockly {
    
    public var typeId: Int = BlocklyType.Default
    
    public weak var blocklyView: UIBlocklyView?
    
    public var previousConnection: PreviousConnection?
    public var nextConnection: NextConnection?
    public var outputConnection: OutputConnection?
    public var inputConnections = [InputConnection]()
    
    public var connections: [Connection] {
        var connections = [Connection]()
        connections.appendIfNotNil(nextConnection)
        connections.appendIfNotNil(previousConnection)
        connections.appendIfNotNil(outputConnection)
        inputConnections.foreach({connections.appendIfNotNil($0)})
        return connections
    }
    
    public var args = [String]()
    
    public init() {
        self.previousConnection = PreviousConnection(sourceBlockly: self)
        self.nextConnection = NextConnection(sourceBlockly: self)
    }

    public func removeFromWorkspace() {
        self.previousConnection?.connect(nil)
        self.outputConnection?.connect(nil)
        Workspace.getInstance().topBlocks.remove(self)
        Workspace.getInstance().blocklys.remove(self)
    }
    
    public func setNextStatement(allowed: Bool) -> Blockly {
        self.nextConnection = allowed ? NextConnection(sourceBlockly: self) : nil
        blocklyView?.nextConnectionDidChange()
        return self
    }
    
    public func setPreviousStatement(allowed: Bool) -> Blockly {
        self.previousConnection = allowed ? PreviousConnection(sourceBlockly: self) : nil
        blocklyView?.previousConnectionDidChange()
        return self
    }
    
    public func setOutput(returnType: Int) -> Blockly {
        outputConnection = OutputConnection(self, returnType)
        blocklyView?.outputConnectionDidChange()
        setNextStatement(false)
        return self
    }
    
    public func appendInputConnection(inputConnection: InputConnection) -> Blockly {
        inputConnections.append(inputConnection)
        return self
    }
    
    public func appendInputMultipleConnections(inputConnections: InputConnection...) -> Blockly {
        inputConnections.foreach({[unowned self] in self.inputConnections.append($0)})
        return self
    }
    
    public func foreach(closure: (Blockly) -> Void) {
        closure(self)
        for inputConnection in inputConnections {
            inputConnection.targetConnection?.sourceBlockly.foreach(closure)
        }
        nextConnection?.targetConnection?.sourceBlockly.foreach(closure)
    }
    
}

public extension Blockly {
    
    public unowned var lastBlockly: Blockly {
        return nextBlockly?.lastBlockly ?? self
    }
    
    public weak var nextBlockly: Blockly? {
        return nextConnection?.targetConnection?.sourceBlockly
    }
    
    public weak var previousBlockly: Blockly? {
        return previousConnection?.targetConnection?.sourceBlockly
    }
    
    public weak var outputBlockly: Blockly? {
        return outputConnection?.targetConnection?.sourceBlockly
    }
    
    public weak var parentBlockly: Blockly? {
        if let previousTargetConnection = previousConnection?.targetConnection {
            return previousTargetConnection is InputStatementConnection ?
                previousTargetConnection.sourceBlockly :
                previousTargetConnection.sourceBlockly.parentBlockly
        }
        return nil
    }
    
    public unowned var topBlockly: Blockly {
        if let previousTargetConnection = previousConnection?.targetConnection {
            if let targetConnection = previousTargetConnection as? InputStatementConnection {
                return self
            }
            return previousTargetConnection.sourceBlockly.topBlockly
        }
        return self
    }
    
}
