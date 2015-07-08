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
    var compassDirection: CompassDirection
    
    init(_ coordinates: Coordinates, _ compassDirection: CompassDirection) {
        self.coordinates = coordinates
        self.compassDirection = compassDirection
    }
    
    init(_ x: Int, _ y: Int, _ compassDirection: CompassDirection) {
        self.init(Coordinates(x, y), compassDirection)
    }
    

    
}

// This cannot be struct for some reason, probably because I want to change the value of visited 
class Destination {
    
    var coordinates: Coordinates
    var visited: Bool = false
    
    init(_ coordinates: Coordinates) {
        self.coordinates = coordinates
        self.visited = false
    }
    
    convenience init(_ x: Int, _ y: Int) {
        self.init(Coordinates(x, y))
    }
    
}