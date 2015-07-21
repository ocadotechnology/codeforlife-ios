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
    
    init() {
        super.init(
            imageNamed: "straight",
            width:      GameMapConfig.Grid.width * Road.scale * 133/200,
            height:     GameMapConfig.Grid.height * Road.scale * 201/200)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}