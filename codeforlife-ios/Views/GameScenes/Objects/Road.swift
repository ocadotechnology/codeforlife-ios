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
        
        private var imageNamed: RoadType
        private var rad: CGFloat
        
        init(node: Node) {
            self.imageNamed = node.imageNamed
            self.rad = node.rad
        }
        
        func build() -> Road {
            switch imageNamed {
                case RoadType.Straight:     return Straight().createWithRotation(rad) as! Road
                case RoadType.Turn:         return Turn().createWithRotation(rad) as! Road
                case RoadType.Crossroads:   return Crossroads().createWithRotation(rad) as! Road
                case RoadType.DeadEnd:      return DeadEnd().createWithRotation(rad) as! Road
                case RoadType.TJunction:    return TJunction().createWithRotation(rad) as! Road
                default:                    return Error().createWithRotation(rad) as! Road
            }
        }
        
    }
    
}