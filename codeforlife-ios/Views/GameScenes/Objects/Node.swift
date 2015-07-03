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
    
    var coordinates: Coordinates
    
    var previousNode: Node?
    var width : CGFloat?
    var height : CGFloat?
    var position : CGPoint?
    var rad: CGFloat?
    var imageNamed: String?
    
//    var position: CGPoint {
//        if let previousNode = self.previousNode {
//            if previousNode.isAboveOf(self) {
//                return CGPoint(
//                    x: previousNode.position.x,
//                    y: previousNode.position.y - previousNode.height!/2 - height!/2)
//            } else if previousNode.isRightOf(self) {
//                return CGPoint(
//                    x: previousNode.position.x - previousNode.width!/2 - width!/2,
//                    y: previousNode.position.y)
//            } else if previousNode.isBelowOf(self) {
//                return CGPoint(
//                    x: previousNode.position.x,
//                    y: previousNode.position.y + previousNode.height!/2 + height!/2)
//            } else if previousNode.isLeftOf(self) {
//                return CGPoint(
//                    x: previousNode.position.x + previousNode.width!/2 + width!/2,
//                    y: previousNode.position.y)
//            }
//        }
//        return CGPoint(
//            x: CGFloat(coordinates.x)*GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
//            y: CGFloat(coordinates.y)*GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
//    }
    
    var direction : Direction {
        return determineDirection()
    }
    
    var connectedNodes = [Node]() {
        didSet {
            evaluateRoadTile()
        }
    }
    
    var trafficLights = [TrafficLight]()
    
    init( _ coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    func addConnectedNode(node: Node) {
        connectedNodes.append(node)
    }
    
    func addConnectedNodeWithBackLink(node: Node) {
        if node.previousNode == nil {
            node.previousNode = self
        }
        self.addConnectedNode(node)
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
    
    func evaluateRoadTile() {
        var imageNamed : String?
        var rad: CGFloat = 0
        var width = GameMapConfig.Grid.width
        var height = GameMapConfig.Grid.height
        var position = CGPointMake(
            CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
            CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
        let PI = CGFloat(M_PI)
        
        switch connectedNodes.count {
        case 1:
            imageNamed = "dead_end"
            if direction.up {
                rad = PI
            } else if direction.right {
                rad = PI*3/2
            } else if direction.down {
                rad = 0
            } else if direction.left {
                rad = PI/2
            }
        case 2:
            if direction.up && direction.right {
                imageNamed = "turn"
                width *= GameMapConfig.straightToTurnRatio
                height *= GameMapConfig.straightToTurnRatio
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! != "turn" {
                        if previousNode.isAboveOf(self) {
                            position = CGPointMake(
                                previousNode.position!.x - previousNode.width!/2 + width/2,
                                previousNode.position!.y - previousNode.height!/2 - height/2)
                        } else {
                            position = CGPointMake(
                                previousNode.position!.x - previousNode.width!/2 - width/2,
                                previousNode.position!.y - previousNode.height!/2 + height/2)
                        }
                    }
                }
                rad = PI
            } else if direction.up && direction.down {
                imageNamed = "straight"
                rad = 0
            } else if direction.up && direction.left {
                imageNamed = "turn"
                width *= GameMapConfig.straightToTurnRatio
                height *= GameMapConfig.straightToTurnRatio
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! != "turn" {
                        if previousNode.isAboveOf(self) {
                            position = CGPointMake(
                                previousNode.position!.x + previousNode.width!/2 - width/2,
                                previousNode.position!.y - previousNode.height!/2 - height/2)
                        } else {
                            position = CGPointMake(
                                previousNode.position!.x + previousNode.width!/2 + width/2,
                                previousNode.position!.y - previousNode.height!/2 + height/2)
                        }
                    }
                }
                rad = PI*3/2
            } else if direction.right && direction.down {
                imageNamed = "turn"
                width *= GameMapConfig.straightToTurnRatio
                height *= GameMapConfig.straightToTurnRatio
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! != "turn" {
                        if previousNode.isRightOf(self) {
                            position = CGPointMake(
                                previousNode.position!.x - previousNode.width!/2 - width/2,
                                previousNode.position!.y + previousNode.height!/2 - height/2)
                        } else {
                            position = CGPointMake(
                                previousNode.position!.x - previousNode.width!/2 + width/2,
                                previousNode.position!.y + previousNode.height!/2 + height/2)
                        }
                    }
                }
                rad = PI/2
            } else if direction.right && direction.left {
                imageNamed = "straight"
                rad = PI/2
            } else if direction.down && direction.left {
                imageNamed = "turn"
                width *= GameMapConfig.straightToTurnRatio
                height *= GameMapConfig.straightToTurnRatio
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! != "turn" {
                        if previousNode.isBelowOf(self) {
                            position = CGPointMake(
                                previousNode.position!.x + previousNode.width!/2 - width/2,
                                previousNode.position!.y + previousNode.height!/2 + height/2)
                        } else {
                            position = CGPointMake(
                                previousNode.position!.x + previousNode.width!/2 + width/2,
                                previousNode.position!.y + previousNode.height!/2 - height/2)
                        }
                    }
                }
                rad = 0
            }
        case 3:
            imageNamed = "t_junction"
            if direction.up && direction.right && direction.down {
                rad = PI
            } else if direction.up && direction.right && direction.left {
                rad = PI/2
            } else if direction.up && direction.down && direction.left {
                rad = 0
            } else if direction.right && direction.down && direction.left {
                rad = PI*3/2
            }
        case 4:
            imageNamed = "crossroads"
            rad  = 0
        default: break
        }
        
        self.imageNamed = imageNamed
        self.width = width
        self.height = height
        self.rad = rad
        self.position = position
    }
    
    func determineDirection() -> Direction{
        var direction = Direction()
        for node in connectedNodes {
            if node.isAboveOf(self) {
                direction.up = true
            } else if node.isRightOf(self) {
                direction.right = true
            } else if node.isBelowOf(self) {
                direction.down = true
            } else if node.isLeftOf(self) {
                direction.left = true
            }
        }
        return direction
    }
    
    func isAboveOf(node: Node) -> Bool {
        return self.coordinates.y > node.coordinates.y
    }
    
    func isBelowOf(node: Node) -> Bool {
        return self.coordinates.y < node.coordinates.y
    }
    
    func isLeftOf(node: Node) -> Bool {
        return self.coordinates.x < node.coordinates.x
    }
    
    func isRightOf(node: Node) -> Bool {
        return self.coordinates.x > node.coordinates.x
    }
    
}

func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.coordinates == rhs.coordinates
}
