//
//  GameObject.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 03/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class GameObject: SKSpriteNode {
    
    let PI = CGFloat(M_PI)
    
    init(imageNamed: String, width: CGFloat, height: CGFloat, rotation: CGFloat) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(
            texture: texture,
            color:UIColor.clearColor(),
            size: CGSizeMake(width, height))
        self.rotate(rotation)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(rad: CGFloat) {
        let action = SKAction.rotateByAngle(-rad, duration: 0)
        self.runAction(action)
    }
    
}