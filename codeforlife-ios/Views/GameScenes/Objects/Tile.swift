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
            width:      GameMapConfig.Grid.width*2,
            height:     GameMapConfig.Grid.height*2)
        self.zPosition = 0
        self.position = CGPointMake(
            CGFloat(coordinates.x+1) * GameMapConfig.Grid.width + GameMapConfig.MapXOffset,
            CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.MapYOffset)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}