//
//  BlocklyCore.swift
//  Pods
//
//  Created by Joey Chan on 19/08/2015.
//
//

import Foundation

public class BlocklyCore {
    
    public var typeId: Int = -1
    
    public weak var blockly: Blockly?
    
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
        self.previousConnection = PreviousConnection(self)
        self.nextConnection = NextConnection(self)
    }

    public func removeFromWorkspace() {
        self.previousConnection?.connect(nil)
        self.outputConnection?.connect(nil)
        Workspace.topBlocks.remove(self)
        Workspace.blocklys.remove(self)
    }
    
    public func setNextStatement(allowed: Bool) -> BlocklyCore {
        self.nextConnection = allowed ? NextConnection(self) : nil
        blockly?.nextConnectionDidChange()
        return self
    }
    
    public func setPreviousStatement(allowed: Bool) -> BlocklyCore {
        self.previousConnection = allowed ? PreviousConnection(self) : nil
        blockly?.previousConnectionDidChange()
        return self
    }
    
    public func setOutput(returnType: ReturnType) -> BlocklyCore {
        outputConnection = OutputConnection(self, returnType)
        blockly?.outputConnectionDidChange()
        setNextStatement(false)
        return self
    }
    
    public func appendInputConnection(inputConnection: InputConnection) -> BlocklyCore {
        inputConnections.append(inputConnection)
        return self
    }
    
    public func appendInputMultipleConnections(inputConnections: InputConnection...) -> BlocklyCore {
        inputConnections.foreach({[unowned self] in self.inputConnections.append($0)})
        return self
    }
    
    public func foreach(closure: (BlocklyCore) -> Void) {
        closure(self)
        for inputConnection in inputConnections {
            inputConnection.targetConnection?.sourceBlock.foreach(closure)
        }
        nextConnection?.targetConnection?.sourceBlock.foreach(closure)
    }
    
}
