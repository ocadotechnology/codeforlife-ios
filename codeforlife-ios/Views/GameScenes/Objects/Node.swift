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
    var position : CGPoint
    var rad: CGFloat?
    var imageNamed: String?
    var isOrigin = false
    
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
        self.position = CGPointMake(
            CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
            CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
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
    
    func setNormalPosition(width: CGFloat, _ height: CGFloat) {
        if let previousNode = self.previousNode {
            if previousNode.isAboveOf(self) {
                position = CGPointMake(
                    previousNode.position.x,
                    previousNode.position.y - previousNode.height!/2 - height/2)
            } else if previousNode.isRightOf(self) {
                position = CGPointMake(
                    previousNode.position.x - previousNode.width!/2 - width/2,
                    previousNode.position.y)
                
            } else if previousNode.isBelowOf(self) {
                position = CGPointMake(
                    previousNode.position.x,
                    previousNode.position.y + previousNode.height!/2 + height/2)
            } else if previousNode.isLeftOf(self) {
                position = CGPointMake(
                    previousNode.position.x + previousNode.width!/2 + width/2,
                    previousNode.position.y)
            }
        }
    }
    
    struct Rotation {
        // Dead End
        static let U = CGFloat(M_PI)
        static let D = CGFloat(0)
        static let L = CGFloat(M_PI/2)
        static let R = CGFloat(M_PI*3/2)
        
        // Straight
        static let H = CGFloat(M_PI/2)
        static let V = CGFloat(0)
        
        // Turns
        static let UR = CGFloat(M_PI)
        static let UL = CGFloat(M_PI/2)
        static let DR = CGFloat(M_PI*3/2)
        static let DL = CGFloat(0)
        
        // T Junction
        static let UDL = CGFloat(0)
        static let UDR = CGFloat(M_PI)
        static let ULR = CGFloat(M_PI/2)
        static let DLR = CGFloat(M_PI*3/2)
    }
    
    struct RoadType {
        static let Straight = "straight"
        static let Turn = "turn"
        static let DeadEnd = "dead_end"
        static let TJunction = "t_junction"
        static let Crossroads = "crossroads"
    }
    
    func evaluateRoadTile() {
        var imageNamed : String?
        var rad: CGFloat = 0
        var width = GameMapConfig.Grid.width
        var height = GameMapConfig.Grid.height
        let PI = CGFloat(M_PI)
        
        switch connectedNodes.count {
        case 1:
            imageNamed = RoadType.DeadEnd
            if direction.up {
                rad = Rotation.U
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! == RoadType.Turn {
                        switch previousNode.rad! {
                        case Rotation.DR: // right & down
                            position = CGPointMake(
                                previousNode.position.x - previousNode.width!/2 + width/2,
                                previousNode.position.y - previousNode.height!/2 - height/2)
                        case Rotation.DL: // left & down
                            position = CGPointMake(
                                previousNode.position.x + previousNode.width!/2 - width/2,
                                previousNode.position.y - previousNode.height!/2 - height/2)
                        default: break
                        }
                    } else {
                        setNormalPosition(width, height)
                    }
                }
            } else if direction.right {
                rad = Rotation.R
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! == RoadType.Turn {
                        switch previousNode.rad! {
                        case Rotation.DL:
                            position = CGPointMake(
                                previousNode.position.x - previousNode.width!/2 - width/2,
                                previousNode.position.y + previousNode.height!/2 - height/2)
                        case Rotation.UL:
                            position = CGPointMake(
                                previousNode.position.x - previousNode.width!/2 - width/2,
                                previousNode.position.y - previousNode.height!/2 + height/2)
                        default: break
                        }
                    } else {
                        setNormalPosition(width, height)
                    }
                }
            } else if direction.down {
                rad = Rotation.D
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! == RoadType.Turn {
                        switch previousNode.rad! {
                        case Rotation.UR:
                            position = CGPointMake(
                                previousNode.position.x - previousNode.width!/2 + width/2,
                                previousNode.position.y + previousNode.height!/2 + height/2)
                        case Rotation.UL:
                            position = CGPointMake(
                                previousNode.position.x + previousNode.width!/2 - width/2,
                                previousNode.position.y + previousNode.height!/2 + height/2)
                        default: break
                        }
                    } else {
                        setNormalPosition(width, height)
                    }
                }
            } else if direction.left {
                rad = Rotation.L
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! == RoadType.Turn {
                        switch previousNode.rad! {
                        case Rotation.UR:  // right & up
                            position = CGPointMake(
                                previousNode.position.x + previousNode.width!/2 + width/2,
                                previousNode.position.y - previousNode.height!/2 + height/2)
                        case Rotation.DR: // right & down
                            position = CGPointMake(
                                previousNode.position.x + previousNode.width!/2 + width/2,
                                previousNode.position.y + previousNode.height!/2 - height/2)
                        default: break
                        }
                    } else {
                        setNormalPosition(width, height)
                    }
                }
            }
            
        case 2:
            if direction.up && direction.right {
                rad = Rotation.UR
                imageNamed = RoadType.Turn
                width *= GameMapConfig.straightToTurnRatio
                height *= GameMapConfig.straightToTurnRatio
                if let previousNode = self.previousNode {
                    if previousNode.isAboveOf(self) {
                        position = CGPointMake(
                            previousNode.position.x - previousNode.width!/2 + width/2,
                            previousNode.position.y - previousNode.height!/2 - height/2)
                    } else {
                        position = CGPointMake(
                            previousNode.position.x - previousNode.width!/2 - width/2,
                            previousNode.position.y - previousNode.height!/2 + height/2)
                    }
                }
            } else if direction.up && direction.down {
                rad = Rotation.V
                imageNamed = RoadType.Straight
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! == RoadType.Turn {
                        if previousNode.isAboveOf(self) {
                            switch previousNode.rad! {
                            case 0:
                                position = CGPointMake(
                                    previousNode.position.x + previousNode.width!/2 - width/2,
                                    previousNode.position.y - previousNode.height!/2 - height/2)
                            case PI*3/2:
                                position = CGPointMake(
                                    previousNode.position.x - previousNode.width!/2 + width/2,
                                    previousNode.position.y - previousNode.height!/2 - height/2)
                            default: break
                            }
                        } else {
                            switch previousNode.rad! {
                            case PI:
                                position = CGPointMake(
                                    previousNode.position.x - previousNode.width!/2 + width/2,
                                    previousNode.position.y + previousNode.height!/2 + height/2)
                            case PI/2:
                                position = CGPointMake(
                                    previousNode.position.x + previousNode.width!/2 - width/2,
                                    previousNode.position.y + previousNode.height!/2 + height/2)
                            default: break
                            }
                        }
                    } else {
                        setNormalPosition(width, height)
                    }
                }
            } else if direction.up && direction.left {
                rad = Rotation.UL
                imageNamed = RoadType.Turn
                width *= GameMapConfig.straightToTurnRatio
                height *= GameMapConfig.straightToTurnRatio
                if let previousNode = self.previousNode {
                    
                    if previousNode.isAboveOf(self) {
                        position = CGPointMake(
                            previousNode.position.x + previousNode.width!/2 - width/2,
                            previousNode.position.y - previousNode.height!/2 - height/2)
                    } else {
                        position = CGPointMake(
                            previousNode.position.x + previousNode.width!/2 + width/2,
                            previousNode.position.y - previousNode.height!/2 + height/2)
                    }
                    
                }
            } else if direction.right && direction.down {
                rad = Rotation.DR
                imageNamed = RoadType.Turn
                width *= GameMapConfig.straightToTurnRatio
                height *= GameMapConfig.straightToTurnRatio
                if let previousNode = self.previousNode {
                    if previousNode.imageNamed! != RoadType.Turn {
                        if previousNode.isRightOf(self) {
                            position = CGPointMake(
                                previousNode.position.x - previousNode.width!/2 - width/2,
                                previousNode.position.y + previousNode.height!/2 - height/2)
                        } else {
                            position = CGPointMake(
                                previousNode.position.x - previousNode.width!/2 + width/2,
                                previousNode.position.y + previousNode.height!/2 + height/2)
                        }
                    } else {
                        setNormalPosition(width, height)
                    }
                }
            } else if direction.right && direction.left {
                rad = Rotation.H
                imageNamed = RoadType.Straight
                if let previousNode = self.previousNode {
                    
                        if previousNode.isRightOf(self) {
                            switch previousNode.rad! {
                            case 0:
                                position = CGPointMake(
                                    previousNode.position.x - previousNode.width!/2 - width/2,
                                    previousNode.position.y + previousNode.height!/2 - height/2)
                            case PI/2:
                                position = CGPointMake(
                                    previousNode.position.x - previousNode.width!/2 - width/2,
                                    previousNode.position.y - previousNode.height!/2 + height/2)
                            default: break
                            }
                        } else {
                            switch previousNode.rad! {
                            case PI*3/2:
                                position = CGPointMake(
                                    previousNode.position.x + previousNode.width!/2 + width/2,
                                    previousNode.position.y + previousNode.height!/2 - height/2)
                            case PI:
                                position = CGPointMake(
                                    previousNode.position.x + previousNode.width!/2 + width/2,
                                    previousNode.position.y - previousNode.height!/2 + height/2)
                            default: break
                            }
                        }
                    
                }
            } else if direction.down && direction.left {
                rad = Rotation.DL
                imageNamed = RoadType.Turn
                width *= GameMapConfig.straightToTurnRatio
                height *= GameMapConfig.straightToTurnRatio
                if let previousNode = self.previousNode {
                    
                        if previousNode.isBelowOf(self) {
                            position = CGPointMake(
                                previousNode.position.x + previousNode.width!/2 - width/2,
                                previousNode.position.y + previousNode.height!/2 + height/2)
                        } else {
                            position = CGPointMake(
                                previousNode.position.x + previousNode.width!/2 + width/2,
                                previousNode.position.y + previousNode.height!/2 - height/2)
                        }
                    
                }
            }
        case 3:
            imageNamed = RoadType.TJunction
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
            imageNamed = RoadType.Crossroads
            rad  = 0
        default: break
        }
        
        self.imageNamed = imageNamed
        self.width = width
        self.height = height
        self.rad = rad
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
