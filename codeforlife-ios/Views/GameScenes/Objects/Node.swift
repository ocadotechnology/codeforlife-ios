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
    
    var width : CGFloat {
        switch imageNamed {
        case RoadType.Turn:
            return GameMapConfig.Grid.width// * GameMapConfig.straightToTurnRatio
        default:
            return GameMapConfig.Grid.width
        }
    }
    
    var height : CGFloat {
        switch imageNamed {
        case RoadType.Turn:
            return GameMapConfig.Grid.height// * GameMapConfig.straightToTurnRatio
        default:
            return GameMapConfig.Grid.height
        }
    }
    
    var position : CGPoint {
        return CGPointMake(
            CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
            CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
    }
    var rad: CGFloat {
        switch connectedNodes.count {
        case 1:
            if direction.up {
                return Rotation.U
            } else if direction.right {
                return Rotation.R
            } else if direction.down {
                return Rotation.D
            } else { // direction.left
                return Rotation.L
            }
            
        case 2:
            if direction.up && direction.right {
                return Rotation.UR
            } else if direction.up && direction.down {
                return Rotation.V
            } else if direction.up && direction.left {
                return Rotation.UL
            } else if direction.right && direction.down {
                return Rotation.DR
            } else if direction.right && direction.left {
                return Rotation.H
            } else { // direction.down && direction.left
                return Rotation.DL
            }
        case 3:
            if direction.up && direction.right && direction.down {
                return Rotation.UDR
            } else if direction.up && direction.right && direction.left {
                return Rotation.ULR
            } else if direction.up && direction.down && direction.left {
                return Rotation.UDL
            } else { // direction.right && direction.down && direction.left
                return Rotation.DLR
            }
        case 4:
            return 0
        default:
            return 0
        }
    }
    
    var isOrigin : Bool {
        return previousNode == nil
    }
    
    var direction = Direction()
    
    var imageNamed: String {
        switch connectedNodes.count {
        case 1:
            return RoadType.DeadEnd
        case 2:
            if (direction.up && direction.down) ||
                (direction.left && direction.right) {
                return RoadType.Straight
            }
            return RoadType.Turn
        case 3:
            return RoadType.TJunction
        case 4:
            return RoadType.Crossroads
        default:
            return RoadType.Error
        }
    }
    
    var connectedNodes = [Node]() {
        didSet {
            direction = Direction()
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
        }
    }
    
    var trafficLights = [TrafficLight]()
    
    init( _ coordinates: Coordinates) {
        self.coordinates = coordinates
//        self.position = CGPointMake(
//            CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
//            CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
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
    
//    func setNormalPosition() {
//        if let previousNode = self.previousNode {
//            if previousNode.isAboveOf(self) {
//                position = CGPointMake(
//                    previousNode.position.x,
//                    previousNode.position.y - previousNode.height/2 - height/2)
//            } else if previousNode.isRightOf(self) {
//                position = CGPointMake(
//                    previousNode.position.x - previousNode.width/2 - width/2,
//                    previousNode.position.y)
//                
//            } else if previousNode.isBelowOf(self) {
//                position = CGPointMake(
//                    previousNode.position.x,
//                    previousNode.position.y + previousNode.height/2 + height/2)
//            } else if previousNode.isLeftOf(self) {
//                position = CGPointMake(
//                    previousNode.position.x + previousNode.width/2 + width/2,
//                    previousNode.position.y)
//            }
//        }
//    }
    
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
        static let Error = "Error"
    }
    
//    func evaluateRoadTile() {
//        var rad: CGFloat = 0
//        let PI = CGFloat(M_PI)
//        
//        switch connectedNodes.count {
//        case 1:
//            if direction.up {
//                if let previousNode = self.previousNode {
//                    if previousNode.imageNamed == RoadType.Turn {
//                        switch previousNode.rad {
//                        case Rotation.DR: // right & down
//                            position = CGPointMake(
//                                previousNode.position.x - previousNode.width/2 + width/2,
//                                previousNode.position.y - previousNode.height/2 - height/2)
//                        case Rotation.DL: // left & down
//                            position = CGPointMake(
//                                previousNode.position.x + previousNode.width/2 - width/2,
//                                previousNode.position.y - previousNode.height/2 - height/2)
//                        default: break
//                        }
//                    } else {
//                        setNormalPosition()
//                    }
//                }
//            } else if direction.right {
//                if let previousNode = self.previousNode {
//                    if previousNode.imageNamed == RoadType.Turn {
//                        switch previousNode.rad {
//                        case Rotation.DL:
//                            position = CGPointMake(
//                                previousNode.position.x - previousNode.width/2 - width/2,
//                                previousNode.position.y + previousNode.height/2 - height/2)
//                        case Rotation.UL:
//                            position = CGPointMake(
//                                previousNode.position.x - previousNode.width/2 - width/2,
//                                previousNode.position.y - previousNode.height/2 + height/2)
//                        default: break
//                        }
//                    } else {
//                        setNormalPosition()
//                    }
//                }
//            } else if direction.down {
//                if let previousNode = self.previousNode {
//                    if previousNode.imageNamed == RoadType.Turn {
//                        switch previousNode.rad {
//                        case Rotation.UR:
//                            position = CGPointMake(
//                                previousNode.position.x - previousNode.width/2 + width/2,
//                                previousNode.position.y + previousNode.height/2 + height/2)
//                        case Rotation.UL:
//                            position = CGPointMake(
//                                previousNode.position.x + previousNode.width/2 - width/2,
//                                previousNode.position.y + previousNode.height/2 + height/2)
//                        default: break
//                        }
//                    } else {
//                        setNormalPosition()
//                    }
//                }
//            } else if direction.left {
//                if let previousNode = self.previousNode {
//                    if previousNode.imageNamed == RoadType.Turn {
//                        switch previousNode.rad {
//                        case Rotation.UR:  // right & up
//                            position = CGPointMake(
//                                previousNode.position.x + previousNode.width/2 + width/2,
//                                previousNode.position.y - previousNode.height/2 + height/2)
//                        case Rotation.DR: // right & down
//                            position = CGPointMake(
//                                previousNode.position.x + previousNode.width/2 + width/2,
//                                previousNode.position.y + previousNode.height/2 - height/2)
//                        default: break
//                        }
//                    } else {
//                        setNormalPosition()
//                    }
//                }
//            }
//            
//        case 2:
//            if direction.up && direction.right {
//                if let previousNode = self.previousNode {
//                    if previousNode.isAboveOf(self) {
//                        position = CGPointMake(
//                            previousNode.position.x - previousNode.width/2 + width/2,
//                            previousNode.position.y - previousNode.height/2 - height/2)
//                    } else {
//                        position = CGPointMake(
//                            previousNode.position.x - previousNode.width/2 - width/2,
//                            previousNode.position.y - previousNode.height/2 + height/2)
//                    }
//                }
//            } else if direction.up && direction.down {
//                if let previousNode = self.previousNode {
//                    if previousNode.imageNamed == RoadType.Turn {
//                        if previousNode.isAboveOf(self) {
//                            switch previousNode.rad {
//                            case 0:
//                                position = CGPointMake(
//                                    previousNode.position.x + previousNode.width/2 - width/2,
//                                    previousNode.position.y - previousNode.height/2 - height/2)
//                            case PI*3/2:
//                                position = CGPointMake(
//                                    previousNode.position.x - previousNode.width/2 + width/2,
//                                    previousNode.position.y - previousNode.height/2 - height/2)
//                            default: break
//                            }
//                        } else {
//                            switch previousNode.rad {
//                            case PI:
//                                position = CGPointMake(
//                                    previousNode.position.x - previousNode.width/2 + width/2,
//                                    previousNode.position.y + previousNode.height/2 + height/2)
//                            case PI/2:
//                                position = CGPointMake(
//                                    previousNode.position.x + previousNode.width/2 - width/2,
//                                    previousNode.position.y + previousNode.height/2 + height/2)
//                            default: break
//                            }
//                        }
//                    } else {
//                        setNormalPosition()
//                    }
//                }
//            } else if direction.up && direction.left {
//                if let previousNode = self.previousNode {
//                    
//                    if previousNode.isAboveOf(self) {
//                        position = CGPointMake(
//                            previousNode.position.x + previousNode.width/2 - width/2,
//                            previousNode.position.y - previousNode.height/2 - height/2)
//                    } else {
//                        position = CGPointMake(
//                            previousNode.position.x + previousNode.width/2 + width/2,
//                            previousNode.position.y - previousNode.height/2 + height/2)
//                    }
//                    
//                }
//            } else if direction.right && direction.down {
//                if let previousNode = self.previousNode {
//                    if previousNode.imageNamed != RoadType.Turn {
//                        if previousNode.isRightOf(self) {
//                            position = CGPointMake(
//                                previousNode.position.x - previousNode.width/2 - width/2,
//                                previousNode.position.y + previousNode.height/2 - height/2)
//                        } else {
//                            position = CGPointMake(
//                                previousNode.position.x - previousNode.width/2 + width/2,
//                                previousNode.position.y + previousNode.height/2 + height/2)
//                        }
//                    } else {
//                        setNormalPosition()
//                    }
//                }
//            } else if direction.right && direction.left {
//                if let previousNode = self.previousNode {
//                    
//                        if previousNode.isRightOf(self) {
//                            switch previousNode.rad {
//                            case 0:
//                                position = CGPointMake(
//                                    previousNode.position.x - previousNode.width/2 - width/2,
//                                    previousNode.position.y + previousNode.height/2 - height/2)
//                            case PI/2:
//                                position = CGPointMake(
//                                    previousNode.position.x - previousNode.width/2 - width/2,
//                                    previousNode.position.y - previousNode.height/2 + height/2)
//                            default: break
//                            }
//                        } else {
//                            switch previousNode.rad {
//                            case PI*3/2:
//                                position = CGPointMake(
//                                    previousNode.position.x + previousNode.width/2 + width/2,
//                                    previousNode.position.y + previousNode.height/2 - height/2)
//                            case PI:
//                                position = CGPointMake(
//                                    previousNode.position.x + previousNode.width/2 + width/2,
//                                    previousNode.position.y - previousNode.height/2 + height/2)
//                            default: break
//                            }
//                        }
//                    
//                }
//            } else if direction.down && direction.left {
//                if let previousNode = self.previousNode {
//                    
//                        if previousNode.isBelowOf(self) {
//                            position = CGPointMake(
//                                previousNode.position.x + previousNode.width/2 - width/2,
//                                previousNode.position.y + previousNode.height/2 + height/2)
//                        } else {
//                            position = CGPointMake(
//                                previousNode.position.x + previousNode.width/2 + width/2,
//                                previousNode.position.y + previousNode.height/2 - height/2)
//                        }
//                    
//                }
//            }
//        case 3:
//            if direction.up && direction.right && direction.down {
//                rad = PI
//            } else if direction.up && direction.right && direction.left {
//                rad = PI/2
//            } else if direction.up && direction.down && direction.left {
//                rad = 0
//            } else if direction.right && direction.down && direction.left {
//                rad = PI*3/2
//            }
//        case 4:
//            rad  = 0
//        default: break
//        }
//    }
    
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
