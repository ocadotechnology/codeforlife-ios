//
//  Coordinates.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public struct Coordinates {
    
    var x: Int
    var y: Int
    
    public var toString: String {
        return ("(\(x), \(y))")
    }
    
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    public func toMapPosition() -> CGPoint {
        return CGPointMake(
            CGFloat(self.x) * GameMapConfig.GridSize.width + GameMapConfig.GridSize.width/2 + GameMapConfig.MapOffset.x,
            CGFloat(self.y) * GameMapConfig.GridSize.height + GameMapConfig.GridSize.height/2 + GameMapConfig.MapOffset.y)
    }
    
}

public func ==(lhs: Coordinates, rhs: Coordinates) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}

public func +(lhs: Coordinates, rhs: Coordinates) -> Coordinates {
    return Coordinates(lhs.x+rhs.x, lhs.y+rhs.y)
}

public func +=(lhs: Coordinates, rhs: Coordinates) -> Coordinates {
    return Coordinates(lhs.x+rhs.x, lhs.y+rhs.y)
}

public func -(lhs: Coordinates, rhs: Coordinates) -> Coordinates {
    return Coordinates(lhs.x-rhs.x, lhs.y-rhs.y)
}
