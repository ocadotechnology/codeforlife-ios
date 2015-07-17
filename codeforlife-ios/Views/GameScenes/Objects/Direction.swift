//
//  Direction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 03/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

enum Direction: Printable {
    case Left
    case Right
    case Up
    case Down
    
    var compassDirection: CompassDirection {
        switch self {
        case .Up:
            return CompassDirection.N
        case .Right:
            return CompassDirection.E
        case .Down:
            return CompassDirection.S
        case .Left:
            return CompassDirection.W
        }
    }
    
    var angle: CGFloat {
        switch self {
        case .Up:
            return CGFloat(M_PI/2)
        case .Right:
            return CGFloat(0)
        case .Down:
            return CGFloat(-M_PI/2)
        case .Left:
            return CGFloat(M_PI)
        }
    }
    
    var description : String {
        switch self {
        case .Up:
            return "Up"
        case .Right:
            return "Right"
        case .Down:
            return "Down"
        case .Left:
            return "Left"
        }
        
    }
}
