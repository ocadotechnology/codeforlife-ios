//
//  Node.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

enum RoadType: String, Printable {
    case Straight = "straight"
    case Turn = "turn"
    case DeadEnd = "dead_end"
    case TJunction = "t_junction"
    case Crossroads = "crossroads"
    case Error = "Error"
    
    var description : String {
        return self.rawValue
    }
    
}

class Node: Equatable {
    
    var coordinates: Coordinates
    
    var previousNode: Node?
    
    
    var trafficLights = [TrafficLight]()
    
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
    
    var imageNamed: RoadType {
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
    
    var position : CGPoint {
        switch imageNamed {
        case .DeadEnd:
            if direction.up {
                return  CGPointMake(
                    CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
                    CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + GameMapConfig.Grid.height*(1-170/202)/2)
            } else if direction.right {
                return CGPointMake(
                    CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.Grid.height*(1-170/202)/2,
                    CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
                
            } else if direction.down {
                return CGPointMake(
                    CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
                    CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 - GameMapConfig.Grid.height*(1-170/202)/2)
                
            } else { // direction.left
                return CGPointMake(
                    CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 - GameMapConfig.Grid.height*(1-170/202)/2,
                    CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
            }
        default: break
        }
        return CGPointMake(
            CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
            CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
    }
    
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
