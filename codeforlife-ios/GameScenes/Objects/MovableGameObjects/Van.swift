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
    
    let engine: AVAudioPlayer
    
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
        self.engine = try! AVAudioPlayer(contentsOfURL: engineSound, fileTypeHint: nil)
        self.engine.numberOfLoops = -1
        self.engine.prepareToPlay()
        super.init(
            imageNamed: "ocadoVan_big",
            width: GameMapConfig.GridSize.width*38/202,
            height: GameMapConfig.GridSize.width*38/202*510/264,
            origin: origin)
        self.reset()
    }
    
    override func reset() {
        self.exploded = false
        self.engineStarted = false
        super.reset()
    }
    
    // Origin of the Van is always one step further from the actual origin
    override func handleResetCurrentCoordinatesOffset() {
        switch origin.compassDirection {
            case .N: currentCoordinates.y++
            case .E: currentCoordinates.x++
            case .S: currentCoordinates.y--
            case .W: currentCoordinates.x--
        default: break
        }
    }
    
    override func handleUpdatePositionOffset() {
        switch direction {
        case .Up:       self.position.x -= self.size.width/2 + GameMapConfig.GridSize.width/45
        self.position.y -= GameMapConfig.GridSize.height/2
        case .Right:    self.position.x -= GameMapConfig.GridSize.width/2
        self.position.y += self.size.width/2 + GameMapConfig.GridSize.height/45
        case .Down:    self.position.x += self.size.width/2 + GameMapConfig.GridSize.width/45
        self.position.y += GameMapConfig.GridSize.height/2
        case .Left:    self.position.x += GameMapConfig.GridSize.width/2
        self.position.y -= self.size.width/2 + GameMapConfig.GridSize.height/45
        }
    }
    
    final func deliver(animated animated: Bool, completion: (() -> Void)?) {
        if let mapScene = self.scene as? MapScene {
            for destination in mapScene.destinations {
                if destination.coordinates == currentCoordinates {
                    destination.visited = true
                }
            }
        }
    }
    
    final func crash(completion: (() -> Void)?) {
        
        let numberOfExplosion = 200
//        let interval:Int = 500
        let range:CGFloat = 30
        let fireToSmokeRatio:UInt32 = 3
        
        for _ in 1 ... numberOfExplosion {
            
            let explosionRange = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * range
            let explosionPosition = CGPointMake(
                                        (CGFloat(Float(arc4random()) / Float(UINT32_MAX))-0.5) * size.width,
                                        (CGFloat(Float(arc4random()) / Float(UINT32_MAX))-0.5) * size.height)
            let fire = arc4random_uniform(fireToSmokeRatio)
            let explosion = GameObject(imageNamed: fire == 0 ? "smoke": "fire", width: 1, height: 1, rotation: 0)
            explosion.position = explosionPosition
            explosion.zPosition = 1.0
            self.addChild(explosion)
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
