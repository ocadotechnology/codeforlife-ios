//
//  Turn.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class Turn: Road {
    
    init() {
        super.init(
            imageNamed: "turn",
            width:      GameMapConfig.GridSize.height * Road.scale * 167/200,
            height:     GameMapConfig.GridSize.height * Road.scale * 167/200)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}