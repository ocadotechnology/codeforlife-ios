//
//  Tile.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 07/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class Tile: GameObject {
    
    init(_ coordinates: Coordinates) {
        super.init(
            imageNamed: "tile1",
            width:      GameMapConfig.GridSize.width*2,
            height:     GameMapConfig.GridSize.height*2,
            rotation:   0)
        self.zPosition = 0
        self.position = CGPointMake(
            CGFloat(coordinates.x+1) * GameMapConfig.GridSize.width + GameMapConfig.MapOffset.x,
            CGFloat(coordinates.y) * GameMapConfig.GridSize.height + GameMapConfig.MapOffset.y)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}