//
//  Player.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class Van: MovableGameObject {
    
    private init(origin: Origin) {
        super.init(
            imageNamed: "ocadoVan_big",
            width: GameMapConfig.Grid.width*38/202,
            height: GameMapConfig.Grid.width*38/202*510/264,
            origin: origin)
    }

    
    class func createWithOrigin(origin: Origin) -> Van {
        var van = Van(origin: origin)
        van.resetPosition()
        return van
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
