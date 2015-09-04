//
//  DeadEnd.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class DeadEnd: Road { // Non-Raphael Image
    
    init(rotation: CGFloat) {
        super.init(
            imageNamed: "dead_end",
            width:      GameMapConfig.GridSize.width * Road.scale * 133/200,
            height:     GameMapConfig.GridSize.height * Road.scale * 166/200,
            rotation: rotation)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}