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
    
    init(node: Node) {
        super.init(
            imageNamed: "house",
            width: GameMapConfig.GridSize.width*254/500,
            height: GameMapConfig.GridSize.height*229/500,
            rotation:   0)
        
        let compassDirection = node.compassDirection
        
        let xPosition = CGFloat(node.coordinates.x) * GameMapConfig.GridSize.width + GameMapConfig.GridSize.width/2 + GameMapConfig.MapOffset.x
        let yPosition = CGFloat(node.coordinates.y) * GameMapConfig.GridSize.height + GameMapConfig.GridSize.height/2 + GameMapConfig.MapOffset.y
        self.position = CGPointMake(xPosition, yPosition)
        
        switch compassDirection {
        case .N:
            self.position.y += GameMapConfig.GridSize.height * ratio1
        case .E:
            self.position.x += GameMapConfig.GridSize.width * ratio1
        case .S:
            self.position.y -= GameMapConfig.GridSize.height * ratio1
        case .W:
            self.position.x -= GameMapConfig.GridSize.width * ratio1
        case .NE:
            self.position.y += GameMapConfig.GridSize.height * ratio2
            self.position.x += GameMapConfig.GridSize.width * ratio2
        case .SE:
            self.position.y -= GameMapConfig.GridSize.height * ratio2
            self.position.x += GameMapConfig.GridSize.width * ratio2
        case .SW:
            self.position.y -= GameMapConfig.GridSize.height * ratio2
            self.position.x -= GameMapConfig.GridSize.width * ratio2
        case .NW:
            self.position.y += GameMapConfig.GridSize.height * ratio2
            self.position.x -= GameMapConfig.GridSize.width * ratio2
        }
        
        let rad = compassDirection.angle + CGFloat(M_PI/2)
        let actionRotate = SKAction.rotateToAngle(rad, duration: 0)
        self.runAction(actionRotate)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}