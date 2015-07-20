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
    
    init(origin: Origin) {
        super.init(
            imageNamed: "ocadoVan_big",
            width: GameMapConfig.Grid.width*38/202,
            height: GameMapConfig.Grid.width*38/202*510/264,
            origin: origin)
        self.resetPosition()
        
    }
    
    override func resetPosition() {
        var rad: CGFloat
        self.position = CGPointMake(
            CGFloat(origin.coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.MapXOffset,
            CGFloat(origin.coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + GameMapConfig.MapYOffset)
        
        switch origin.compassDirection {
        case .N:
            self.position.x -= self.width/2 + GameMapConfig.Grid.width/45
            self.position.y += GameMapConfig.Grid.height/2
        case .E:
            self.position.x += GameMapConfig.Grid.width/2
            self.position.y += self.width/2 + GameMapConfig.Grid.height/45
        case .S:
            self.position.x += self.width/2 + GameMapConfig.Grid.width/45
            self.position.y -= GameMapConfig.Grid.height/2
        case .W:
            self.position.x -= GameMapConfig.Grid.width/2
            self.position.y -= self.width/2 + GameMapConfig.Grid.height/45
        default : break
        }
        
        rad = origin.compassDirection.angle
        self.direction = origin.compassDirection.direction
        let actionRotate = SKAction.rotateToAngle(rad, duration: 0)
        self.runAction(actionRotate)
        resetCurrentCoordinates()
    }
    
    // Origin of the Van is always one step further from the actual origin
    private func resetCurrentCoordinates() {
        self.currentCoordinates = self.origin.coordinates
        switch origin.compassDirection {
        case .N: currentCoordinates.y++
        case .E: currentCoordinates.x++
        case .S: currentCoordinates.y--
        case .W: currentCoordinates.x--
        default: break
        }
    }
    
    final func deliver() {
        if let map = SharedContext.MainGameViewController?.gameMapViewController?.map {
            for destination in map.destinations {
                if destination.coordinates == currentCoordinates {
                    destination.visited = true
                }
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
