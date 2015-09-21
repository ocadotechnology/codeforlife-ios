//
//  Workspace.swift
//  Pods
//
//  Created by Joey Chan on 19/08/2015.
//
//

import Foundation

public class Workspace {
    
    private static let instance = Workspace()
    
    public static func getInstance() -> Workspace {
        return instance
    }
    
    public var topBlocks = Blocklys()
    public var blocklys = Blocklys()
}

public extension Workspace { // Read-Only Variables
    
    public var connections: [Connection] {
        var connections = [Connection]()
        blocklys.foreach({
            for connection in $0.connections {
                connections.append(connection)
            }
        })
        return connections
    }
    
    public var previousConnections: [Connection] {
        return connections.filter({$0 is PreviousConnection})
    }
    
    public var nextConnections: [Connection] {
        return connections.filter({$0 is NextConnection})
    }
    
    public var outputConnections: [Connection] {
        return connections.filter({$0 is OutputConnection})
    }
    
    public var inputConnections: [Connection] {
        return connections.filter({$0 is InputConnection})
    }
}