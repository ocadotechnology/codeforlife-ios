//
//  Player.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation
import AVFoundation

class Van: MovableGameObject {
    
    var engine = AVAudioPlayer()
    
    var exploded = false {
        didSet {
            self.texture = SKTexture(imageNamed: exploded ? "van_wreckage" : "ocadoVan_big")
        }
    }
    
    var engineStarted = false {
        didSet {
            if engineStarted {
                engine.play()
            } else {
                engine.stop()
            }
        }
    }
    
    init(origin: Origin) {
        let engineSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("moving", ofType: "mp3")!)
        self.engine = AVAudioPlayer(contentsOfURL: engineSound, error: nil)
        self.engine.numberOfLoops = -1
        self.engine.prepareToPlay()
        super.init(
            imageNamed: "ocadoVan_big",
            width: GameMapConfig.GridSize.width*38/202,
            height: GameMapConfig.GridSize.width*38/202*510/264,
            origin: origin)
        self.reset()
        
    }
    
    final override func reset() {
        self.exploded = false
        self.engineStarted = false
        super.reset()
    }
    
    // Origin of the Van is always one step further from the actual origin
    final override func resetCurrentCoordinates() {
        self.direction = origin.compassDirection.direction
        self.currentCoordinates = origin.coordinates
        switch origin.compassDirection {
            case .N: currentCoordinates.y++
            case .E: currentCoordinates.x++
            case .S: currentCoordinates.y--
            case .W: currentCoordinates.x--
        default: break
        }
    }
    
    final override func updatePosition() {
        self.position = CGPointMake(
            CGFloat(currentCoordinates.x) * GameMapConfig.GridSize.width + GameMapConfig.GridSize.width/2 + GameMapConfig.MapXOffset,
            CGFloat(currentCoordinates.y) * GameMapConfig.GridSize.height + GameMapConfig.GridSize.height/2 + GameMapConfig.MapYOffset)
        
        // Handle Offset
        switch direction {
            case .Up:       self.position.x -= self.width/2 + GameMapConfig.GridSize.width/45
                            self.position.y -= GameMapConfig.GridSize.height/2
            case .Right:    self.position.x -= GameMapConfig.GridSize.width/2
                            self.position.y += self.width/2 + GameMapConfig.GridSize.height/45
            case .Down:    self.position.x += self.width/2 + GameMapConfig.GridSize.width/45
                            self.position.y += GameMapConfig.GridSize.height/2
            case .Left:    self.position.x += GameMapConfig.GridSize.width/2
                            self.position.y -= self.width/2 + GameMapConfig.GridSize.height/45
        default : break
        }
        
        // Handle Direction
        let actionRotate = SKAction.rotateToAngle(direction.compassDirection.angle, duration: 0)
        self.runAction(actionRotate)
    }
    
    final func deliver(#animated: Bool, completion: (() -> Void)?) {
        if let map = SharedContext.MainGameViewController?.gameMapViewController?.map {
            for destination in map.destinations {
                if destination.coordinates == currentCoordinates {
                    destination.visited = true
                }
            }
        }
    }
    
    final func crash(completion: (() -> Void)?) {
        
        let numberOfExplosion = 200
        let interval:Int = 500
        let range:CGFloat = 25
        let fireToSmokeRatio:UInt32 = 3
        
        for i in 1 ... numberOfExplosion {
            
            let explosionRange = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * range
            var explosionPosition = self.position
            explosionPosition.x += (CGFloat(Float(arc4random()) / Float(UINT32_MAX)) - 0.5) * range
            explosionPosition.y += (CGFloat(Float(arc4random()) / Float(UINT32_MAX)) - 0.5) * range
            var fire = arc4random_uniform(fireToSmokeRatio)
            var explosion = GameObject(imageNamed: fire == 0 ? "smoke": "fire", width: 1, height: 1)
            explosion.position = explosionPosition
            explosion.zPosition = 1.0
            SharedContext.MainGameViewController?.gameMapViewController?.map?.addChild(explosion)
            explosion.runAction(SKAction.scaleBy(explosionRange, duration: 1)) {
                [unowned self, unowned explosion] in
                self.exploded = true
                explosion.runAction(SKAction.scaleBy(1/explosionRange, duration: 1)) {
                    [unowned explosion = explosion] in
                    explosion.removeFromParent()
                    
                }
            }
        }
        completion?()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
