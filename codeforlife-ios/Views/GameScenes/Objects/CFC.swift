//
//  CFC.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class CFC: GameObject {
    
    init(origin: Origin) {
        super.init(
            imageNamed: "OcadoCFC_no_road",
            width: GameMapConfig.Grid.width,
            height: GameMapConfig.Grid.height*589/689)
        self.position = CGPointMake(
            CGFloat(origin.coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.MapXOffset,
            CGFloat(origin.coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + GameMapConfig.MapYOffset)
        
        switch origin.compassDirection {
        case .N:
            self.position.x -= GameMapConfig.Grid.width/25
            self.position.y -= GameMapConfig.Grid.height/4
        case .E:
            self.position.x -= GameMapConfig.Grid.width/4
            self.position.y += GameMapConfig.Grid.height/25
        case .S:
            self.position.x += GameMapConfig.Grid.width/25
            self.position.y += GameMapConfig.Grid.height/4
        case .W:
            self.position.x += GameMapConfig.Grid.width/4
            self.position.y -= GameMapConfig.Grid.height/25
        }
        
        let rad = origin.compassDirection.angle
        let actionRotate = SKAction.rotateToAngle(rad, duration: 0)
        self.runAction(actionRotate)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}