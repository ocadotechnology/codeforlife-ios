//
//  Destination.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation

// This cannot be struct for some reason, probably because I want to change the value of visited
class Destination {
    
    var coordinates: Coordinates
    var visited: Bool = false {
        didSet {
            self.border?.strokeColor = visited ? UIColor.greenColor() : UIColor.redColor()
        }
    }
    
    var border: SKShapeNode?
    
    init(_ coordinates: Coordinates) {
        self.coordinates = coordinates
        self.visited = false
    }
    
    convenience init(_ x: Int, _ y: Int) {
        self.init(Coordinates(x, y))
    }
    
    func createBorder() -> SKShapeNode {
        self.border = SKShapeNode(
            rect: CGRect(
                origin: CGPointMake(
                    CGFloat(coordinates.x) * GameMapConfig.GridSize.width + GameMapConfig.MapXOffset,
                    CGFloat(coordinates.y) * GameMapConfig.GridSize.height + GameMapConfig.MapYOffset),
                size: GameMapConfig.GridSize))
        self.border?.lineWidth = 2
        self.border?.strokeColor = UIColor.redColor()
        self.border?.zPosition = 0.5
        return self.border!
    }
    
}