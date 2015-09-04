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
            width: GameMapConfig.GridSize.width,
            height: GameMapConfig.GridSize.height*589/689,
            rotation: 0)
        self.position = CGPointMake(
            CGFloat(origin.coordinates.x) * GameMapConfig.GridSize.width + GameMapConfig.GridSize.width/2 + GameMapConfig.MapOffset.x,
            CGFloat(origin.coordinates.y) * GameMapConfig.GridSize.height + GameMapConfig.GridSize.height/2 + GameMapConfig.MapOffset.y)
        
        switch origin.compassDirection {
        case .N:
            self.position.x -= GameMapConfig.GridSize.width/25
            self.position.y -= GameMapConfig.GridSize.height/4
        case .E:
            self.position.x -= GameMapConfig.GridSize.width/4
            self.position.y += GameMapConfig.GridSize.height/25
        case .S:
            self.position.x += GameMapConfig.GridSize.width/25
            self.position.y += GameMapConfig.GridSize.height/4
        case .W:
            self.position.x += GameMapConfig.GridSize.width/4
            self.position.y -= GameMapConfig.GridSize.height/25
        default : break
        }
        
        let rad = origin.compassDirection.angle
        let actionRotate = SKAction.rotateToAngle(rad, duration: 0)
        self.runAction(actionRotate)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}