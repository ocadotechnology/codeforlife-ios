//
//  RoadTile.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 03/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class Road: GameObject {
    
    static let scale: CGFloat = 1.00
    
    class Builder {
        
        private let imageNamed: RoadType
        private let rad: CGFloat
        private let position: CGPoint
        private let zPosition: CGFloat = 0
        
        init(node: Node) {
            self.imageNamed = node.roadType
            self.rad = node.rad
            self.position = node.position
        }
        
        func build() -> Road {
            let road: Road
            switch imageNamed {
                case RoadType.Straight:     road = Straight(rotation: rad)
                case RoadType.Turn:         road = Turn(rotation: rad)
                case RoadType.Crossroads:   road = Crossroads(rotation: rad)
                case RoadType.DeadEnd:      road = DeadEnd(rotation: rad)
                case RoadType.TJunction:    road = TJunction(rotation: rad)
                default:                    road = Error()
            }
            road.position = position
            road.zPosition = zPosition
            return road
        }
        
    }
    
}