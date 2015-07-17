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
    
    let ratio1: CGFloat = 4/7
    let ratio2: CGFloat = 1/4
    
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
            self.position.y += GameMapConfig.Grid.height * ratio1
        case .E:
            self.position.x += GameMapConfig.Grid.width * ratio1
        case .S:
            self.position.y -= GameMapConfig.Grid.height * ratio1
        case .W:
            self.position.x -= GameMapConfig.Grid.width * ratio1
        case .NE:
            self.position.y += GameMapConfig.Grid.height * ratio2
            self.position.x += GameMapConfig.Grid.width * ratio2
        case .SE:
            self.position.y -= GameMapConfig.Grid.height * ratio2
            self.position.x += GameMapConfig.Grid.width * ratio2
        case .SW:
            self.position.y -= GameMapConfig.Grid.height * ratio2
            self.position.x -= GameMapConfig.Grid.width * ratio2
        case .NW:
            self.position.y += GameMapConfig.Grid.height * ratio2
            self.position.x -= GameMapConfig.Grid.width * ratio2
        default: break
        }
        
        let rad = origin.compassDirection.angle + CGFloat(M_PI/2)
        let actionRotate = SKAction.rotateToAngle(rad, duration: 0)
        self.runAction(actionRotate)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}