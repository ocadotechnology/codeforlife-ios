//
//  Coordinates.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

struct Coordinates {
    var x: Int
    var y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
}

func ==(lhs: Coordinates, rhs: Coordinates) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}
