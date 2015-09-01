//
//  Workspace.swift
//  Pods
//
//  Created by Joey Chan on 19/08/2015.
//
//

import Foundation

public class Workspace {
    public static var topBlocks = BlocklyCores()
    public static var blocklys = BlocklyCores()
}

public extension Workspace { // Read-Only Variables
    
    public static var connections: [Connection] {
        var connections = [Connection]()
        blocklys.foreach({
            for connection in $0.connections {
                connections.append(connection)
            }
        })
        return connections
    }
    
    public static var previousConnections: [Connection] {
        return connections.filter({$0 is PreviousConnection})
    }
    
    public static var nextConnections: [Connection] {
        return connections.filter({$0 is NextConnection})
    }
    
    public static var outputConnections: [Connection] {
        return connections.filter({$0 is OutputConnection})
    }
    
    public static var inputConnections: [Connection] {
        return connections.filter({$0 is InputConnection})
    }
}