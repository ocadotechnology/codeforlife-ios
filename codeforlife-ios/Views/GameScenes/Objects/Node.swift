//
//  Node.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class Node: Equatable {
    
    enum Type {
        case Road
    }
    
    var type: Type {
        // This variable should return which kind of road_tile the map should generate
        return Type.Road
    }
    
    var rotation: CGFloat {
        // This function should return the angle the road_tile image should rotate
        return CGFloat(M_PI)
    }
    
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
    
}

func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.coordinates == rhs.coordinates
}
