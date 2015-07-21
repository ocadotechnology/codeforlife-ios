//
//  TJunction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class TJunction: Road {
    init() {
        super.init(
            imageNamed: "t_junction",
            width:      GameMapConfig.Grid.width * Road.scale * 167/200,
            height:     GameMapConfig.Grid.height * Road.scale * 202/200)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}