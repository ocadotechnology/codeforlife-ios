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
            width:      GameMapConfig.Grid.width,
            height:     GameMapConfig.Grid.height)
        
        self.position = CGPointMake(
            CGFloat(coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.MapXOffset,
            CGFloat(coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + GameMapConfig.MapYOffset)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}