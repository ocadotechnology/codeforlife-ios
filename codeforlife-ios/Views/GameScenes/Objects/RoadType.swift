//
//  RoadType.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

enum RoadType: String, Printable {
    
    case Straight = "straight"
    case Turn = "turn"
    case DeadEnd = "dead_end"
    case TJunction = "t_junction"
    case Crossroads = "crossroads"
    case Error = "Error"
    
    var description : String {
        return self.rawValue
    }
    
    var offset : CGFloat {
        switch self {
        case .DeadEnd:
            return GameMapConfig.Grid.height*(1-170/202)/2
        case .Turn:
            return GameMapConfig.Grid.height*(1-169/202)/2
        case .TJunction:
            return GameMapConfig.Grid.height*(1-170/202)/2
        default: break
        }
        return 0
    }
    
}
