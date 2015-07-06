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
    
    init(_ x: Int, _ y: Int, _ compassDirection: CompassDirection) {
        self.coordinates = Coordinates(x, y)
        self.compassDirection = compassDirection
    }
    
}