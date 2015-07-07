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
        }
        
        rad = origin.compassDirection.angle
        self.direction = origin.compassDirection.direction
        let actionRotate = SKAction.rotateToAngle(rad, duration: 0)
        self.runAction(actionRotate)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveForward(_ completion : (() -> Void)? = nil) {
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        self.moveForward(GameMapConfig.Grid.height, duration: 0.5) {
            CommandFactory.NativeEnableDirectDriveCommand().execute()
            completion?()
        }
    }
    
    override func turnLeft(_ completion : (() -> Void)? = nil) {
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        self.turnLeft(GameMapConfig.Grid.height*(33+24+22)/202, duration: 0.5) {
            CommandFactory.NativeEnableDirectDriveCommand().execute()
            completion?()
        }
    }
    
    override func turnRight(_ completion : (() -> Void)? = nil) {
        CommandFactory.NativeDisableDirectDriveCommand().execute()
        self.turnRight(GameMapConfig.Grid.height*(33+24+44+22)/202, duration: 0.7) {
            CommandFactory.NativeEnableDirectDriveCommand().execute()
            completion?()
        }
    }
    
}
