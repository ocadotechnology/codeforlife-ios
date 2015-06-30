//
//  Player.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class Player: SKSpriteNode {
    
    var horizontal = true
    
    init() {
        let texture = SKTexture(image: UIImage(named: "van")!)
        super.init(texture: texture, color: nil, size: CGSize(width: 80, height: 40))
    }
    
    func moveForward(movement: CGFloat, duration: NSTimeInterval) {
        var actionMove = horizontal ?
                SKAction.moveToX(position.x + movement, duration: duration) :
                SKAction.moveToY(position.y + movement, duration: duration)
        self.runAction(actionMove)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
