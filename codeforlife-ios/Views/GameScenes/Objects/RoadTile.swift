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

class RoadTile: GameObject {
    
    class Builder {
        
        private var imageNamed: String
        private var rad: CGFloat
        
        init(node: Node) {
            self.imageNamed = node.imageNamed!
            self.rad = node.rad!
        }
        
        func build() -> RoadTile? {
            switch imageNamed {
                case "straight":
                    return Straight().createWithRotation(rad) as? RoadTile
            case "turn":
                return Turn().createWithRotation(rad) as? RoadTile
            case "crossroads":
                return Crossroads().createWithRotation(rad) as? RoadTile
            case "dead_end":
                return DeadEnd().createWithRotation(rad) as? RoadTile
            case "t_junction":
                return TJunction().createWithRotation(rad) as? RoadTile
            default: break;
            }
            return nil
        }
        
    }
}

class Straight: RoadTile {
    init() {
        super.init(
            imageNamed: "straight",
            width: GameMapConfig.Grid.width,
            height: GameMapConfig.Grid.height)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Turn: RoadTile {
    init() {
        super.init(
            imageNamed: "turn",
            width: GameMapConfig.Grid.width * GameMapConfig.straightToTurnRatio,
            height: GameMapConfig.Grid.height * GameMapConfig.straightToTurnRatio)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Crossroads: RoadTile {
    init() {
        super.init(
            imageNamed: "crossroads",
            width: GameMapConfig.Grid.width,
            height: GameMapConfig.Grid.height)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TJunction: RoadTile {
    init() {
        super.init(
            imageNamed: "t_junction",
            width: GameMapConfig.Grid.width,
            height: GameMapConfig.Grid.height)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DeadEnd: RoadTile {
    init() {
        super.init(
            imageNamed: "dead_end",
            width: GameMapConfig.Grid.width,
            height: GameMapConfig.Grid.height)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Error: RoadTile {
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