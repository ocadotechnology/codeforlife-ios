//
//  Origin.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation
import CoreData

public class Origin {
    
    var coordinates: Coordinates
    var compassDirection: CompassDirection
    
    init(_ coordinates: Coordinates, _ compassDirection: CompassDirection) {
        self.coordinates = coordinates
        self.compassDirection = compassDirection
    }
    
    convenience init(_ x: Int, _ y: Int, _ compassDirection: CompassDirection) {
        self.init(Coordinates(x, y), compassDirection)
    }
    

    
}