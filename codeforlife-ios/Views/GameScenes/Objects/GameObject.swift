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
    
    var width: CGFloat
    var height: CGFloat
    
    init(imageNamed: String, width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(
            texture: texture,
            color:UIColor.clearColor(),
            size: CGSize(width: self.width, height: self.height))
    }
    
    func createWithRotation(rad: CGFloat) -> GameObject{
        rotate(rad)
        return self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(rad: CGFloat) {
        let action = SKAction.rotateByAngle(-rad, duration: 0)
        self.runAction(action)
    }
    
}