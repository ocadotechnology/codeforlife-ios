//
//  Error.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class Error: Road {
    init() {
        super.init(
            imageNamed: "Error",
            width:      GameMapConfig.Grid.width,
            height:     GameMapConfig.Grid.height)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}