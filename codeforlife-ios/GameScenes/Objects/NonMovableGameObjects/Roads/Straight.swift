//
//  Straight.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class Straight: Road {
    
    init(rotation: CGFloat) {
        super.init(
            imageNamed: "straight",
            width:      GameMapConfig.GridSize.width * Road.scale * 133/200,
            height:     GameMapConfig.GridSize.height * Road.scale * 201/200,
            rotation: rotation)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}