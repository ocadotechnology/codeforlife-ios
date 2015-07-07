//
//  House.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 07/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class House: GameObject {
    
    init(origin: Origin) {
        super.init(
            imageNamed: "house",
            width: GameMapConfig.Grid.width*254/500,
            height: GameMapConfig.Grid.height*229/500)
        
        self.position = CGPointMake(
            CGFloat(origin.coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.MapXOffset,
            CGFloat(origin.coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + GameMapConfig.MapYOffset)
        
        switch origin.compassDirection {
        case .N:
            self.position.y += GameMapConfig.Grid.height*4/7
        case .E:
            self.position.x += GameMapConfig.Grid.width*4/7
        case .S:
            self.position.y -= GameMapConfig.Grid.height*4/7
        case .W:
            self.position.x -= GameMapConfig.Grid.width*4/7
        }
        
        let rad = origin.compassDirection.angle + CGFloat(M_PI/2)
        let actionRotate = SKAction.rotateToAngle(rad, duration: 0)
        self.runAction(actionRotate)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}