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
    
    struct Direction {
        var up    : Bool = false
        var right : Bool = false
        var down  : Bool = false
        var left  : Bool = false
    }
    
    let coordinates     : Coordinates
    var direction       : Direction
    var isDestination = false
    var connectedNodes  : [Node] { didSet {updateDirection()} }
    var roadType        : RoadType { return self.convertToRoadType() }
    var rad             : CGFloat  { return self.convertToRotation() }
    var compassDirection: CompassDirection { return self.convertToCompassDirection() }
    var position        : CGPoint  { return self.convertToPosition() }
    
    weak var previousNode: Node?
    
    init( _ coordinates: Coordinates) {
        self.connectedNodes = [Node]()
        self.coordinates = coordinates
        self.direction = Direction()
    }
    
    func addConnectedNode(node: Node) {
        if node.previousNode == nil {
            node.previousNode = self
        }
        connectedNodes.append(node)
    }
    
    func addConnectedNodeWithBackLink(node: Node) {
        self.addConnectedNode(node)
        node.addConnectedNode(self)
    }
    
    func indexInConnectedNodes(node: Node) -> Int? {
        for (index, connectedNode) in enumerate(connectedNodes) {
            if node == connectedNode {
                return index
            }
        }
        return nil
    }
    
    private func isAboveOf(node: Node)  -> Bool { return self.coordinates.y > node.coordinates.y }
    private func isBelowOf(node: Node)  -> Bool { return self.coordinates.y < node.coordinates.y }
    private func isLeftOf(node: Node)   -> Bool { return self.coordinates.x < node.coordinates.x }
    private func isRightOf(node: Node)  -> Bool { return self.coordinates.x > node.coordinates.x }
    
    private func convertToRotation() -> CGFloat {
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
        default:
            return 0
        }
    }
    
    private func convertToRoadType() -> RoadType {
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
    
    private func convertToPosition() -> CGPoint {
        var result = CGPointMake(
            CGFloat(coordinates.x) * GameMapConfig.GridSize.width + GameMapConfig.GridSize.width/2 + GameMapConfig.MapOffset.x,
            CGFloat(coordinates.y) * GameMapConfig.GridSize.height + GameMapConfig.GridSize.height/2 + GameMapConfig.MapOffset.y)
        result.y += direction.up    ? roadType.offset : 0
        result.x += direction.right ? roadType.offset : 0
        result.y -= direction.down  ? roadType.offset : 0
        result.x -= direction.left  ? roadType.offset : 0
        return result
    }
    
    private func convertToCompassDirection() -> CompassDirection {
        var compassDirection = CompassDirection.N
        if connectedNodes.count == 2 &&
            !(direction.up && direction.down) &&
            !(direction.left && direction.right) {
                if !direction.up && !direction.right {
                    compassDirection = CompassDirection.NE
                } else if !direction.up && !direction.left {
                    compassDirection = CompassDirection.NW
                } else if !direction.right && !direction.down {
                    compassDirection = CompassDirection.SE
                } else { //!direction.down && !direction.left
                    compassDirection = CompassDirection.SW
                }
        } else {
            if !direction.up {
                compassDirection = CompassDirection.N
            } else if !direction.right {
                compassDirection = CompassDirection.E
            } else if !direction.down {
                compassDirection = CompassDirection.S
            } else { //!direction.left
                compassDirection = CompassDirection.W
            }
        }
        return compassDirection
    }
    
    private func updateDirection() {
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

func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.coordinates == rhs.coordinates
}
