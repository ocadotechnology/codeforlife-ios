//
//  RoadTile.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 03/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class Road: GameObject {
    
    static let scale: CGFloat = 1.00
    
    class Builder {
        
        private var imageNamed: RoadType
        private var rad: CGFloat
        
        init(node: Node) {
            self.imageNamed = node.imageNamed
            self.rad = node.rad
        }
        
        func build() -> Road {
            switch imageNamed {
            case RoadType.Straight:
                return Straight().createWithRotation(rad) as! Road
            case RoadType.Turn:
                return Turn().createWithRotation(rad) as! Road
            case RoadType.Crossroads:
                return Crossroads().createWithRotation(rad) as! Road
            case RoadType.DeadEnd:
                return DeadEnd().createWithRotation(rad) as! Road
            case RoadType.TJunction:
                return TJunction().createWithRotation(rad) as! Road
            default:
                return Error().createWithRotation(rad) as! Road
            }
        }
        
    }
}

class Straight: Road {
    
    init() {
        super.init(
            imageNamed: "straight",
            width: GameMapConfig.Grid.width * Road.scale * 133/200,
            height: GameMapConfig.Grid.height * Road.scale * 201/200)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Turn: Road {
    
    init() {
        super.init(
            imageNamed: "turn",
            width: GameMapConfig.Grid.height * Road.scale * 167/200,
            height: GameMapConfig.Grid.height * Road.scale * 167/200)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Crossroads: Road {
    init() {
        super.init(
            imageNamed: "crossroads",
            width: GameMapConfig.Grid.height * Road.scale * 202/200,
            height: GameMapConfig.Grid.height * Road.scale * 202/200)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TJunction: Road {
    init() {
        super.init(
            imageNamed: "t_junction",
            width: GameMapConfig.Grid.width * Road.scale * 167/200,
            height: GameMapConfig.Grid.height * Road.scale * 202/200)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DeadEnd: Road { // Non-Raphael Image
    init() {
        super.init(
            imageNamed: "dead_end",
            width: GameMapConfig.Grid.width * Road.scale * 133/200,
            height: GameMapConfig.Grid.height * Road.scale * 166/200)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Error: Road {
    init() {
        super.init(
            imageNamed: "Error",
            width: GameMapConfig.Grid.width,
            height: GameMapConfig.Grid.height)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}