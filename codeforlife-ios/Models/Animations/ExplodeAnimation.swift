//
//  ExplodeAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class ExplodeAnimation: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Explode")
        let numberOfExplosion = 200
        let interval:Int = 500
        let range:CGFloat = 25
        let fireToSmokeRatio:UInt32 = 3
        if let vanPosition = SharedContext.MainGameViewController?.gameMapViewController?.map?.van.position {
            for i in 1 ... numberOfExplosion {
                let explosionRange = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * range
                var explosionPosition = vanPosition
                explosionPosition.x += (CGFloat(Float(arc4random()) / Float(UINT32_MAX)) - 0.5) * range
                explosionPosition.y += (CGFloat(Float(arc4random()) / Float(UINT32_MAX)) - 0.5) * range
                var fire = arc4random_uniform(fireToSmokeRatio)
                var explosion = GameObject(imageNamed: fire == 0 ? "smoke": "fire", width: 1, height: 1)
                explosion.position = explosionPosition
                explosion.zPosition = 1.0
                SharedContext.MainGameViewController?.gameMapViewController?.map?.addChild(explosion)
                explosion.runAction(SKAction.scaleBy(explosionRange, duration: 1)) {
                    [unowned explosion = explosion] in
                    SharedContext.MainGameViewController?.gameMapViewController?.map?.van.texture = SKTexture(imageNamed: "van_wreckage")
                    explosion.runAction(SKAction.scaleBy(1/explosionRange, duration: 1)) {
                        [unowned explosion = explosion] in
                        explosion.removeFromParent()
                    }
                }
            }
        }
        completion?()
    }
    
}