//
//  CompassDirection.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

enum CompassDirection {
    case N
    case E
    case S
    case W
    
    var direction : Direction {
        switch self {
        case .N :
            return Direction.Up
        case .E :
            return Direction.Right
        case .S :
            return Direction.Down
        case .W :
            return Direction.Left
        }
    }
    
    var angle: CGFloat {
        switch self {
        case .N:
            return CGFloat(0)
        case .E:
            return CGFloat(-M_PI/2)
        case .S:
            return CGFloat(M_PI)
        case .W:
            return CGFloat(M_PI/2)
        }
    }
}
