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
    
    init(imageNamed: String, width: CGFloat, height: CGFloat) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(
            texture: texture,
            color:UIColor.clearColor(),
            size: CGSize(width: width, height: height))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(rad: CGFloat) {
        let action = SKAction.rotateByAngle(-rad, duration: 0)
        self.runAction(action)
    }
    
}