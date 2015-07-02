//
//  Node.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Node: Equatable {
    
    var coordinates: Coordinates
    lazy var connectedNodes = [Node]()
    lazy var trafficLights = [TrafficLight]()
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    func addConnectedNode(node: Node) {
        connectedNodes.append(node)
    }
    
    func addConnectedNodeWithBackLink(node: Node) {
        connectedNodes.append(node)
        node.addConnectedNode(self)
    }
    
    func indexInConnectedNodes(node: Node) -> Int? {
        for index in 0..<connectedNodes.count {
            if node == connectedNodes[index] {
                return index
            }
        }
        return nil
    }
    
    func removeDoublyConnectedNode(node: Node) {
        if let index = indexInConnectedNodes(node) {
            connectedNodes.removeAtIndex(index)
        }
        if let index2 = node.indexInConnectedNodes(self) {
            node.connectedNodes.removeAtIndex(index2)
        }
    }
    
    func parseData(nodeData: [AnyObject]) -> [Node] {
        var nodes = [Node]()
        
        for index in 0 ..< nodes.count {
            //TODO
        }
        
        return nodes
    }

    
}

func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.coordinates == rhs.coordinates
}
