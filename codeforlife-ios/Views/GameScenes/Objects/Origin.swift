//
//  Origin.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

struct Origin {
    
    var coordinates: Coordinates
    var direction: Direction
    
    init(_ x: Int, _ y: Int, _ direction: Direction) {
        self.coordinates = Coordinates(x, y)
        self.direction = direction
    }
    
    func initialPosition(object: GameObject) -> CGPoint {
        var position = CGPointMake(
            CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.Grid.height/2,
            CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + object.width/2 + 1.5)
        return position
    }
    
}