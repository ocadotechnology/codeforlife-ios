//
//  MovementAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 20/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class MovementAnimation: Animation {
    
    unowned var object: MovableGameObject
    
    init(object: MovableGameObject) {
        self.object = object
    }
    
    final func moveForward(movement: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        var actionMove: SKAction
        switch object.direction {
        case .Left :
            actionMove = SKAction.moveBy(CGVector(dx: -movement, dy: 0), duration: duration)
        case .Right:
            actionMove = SKAction.moveBy(CGVector(dx:  movement, dy: 0), duration: duration)
        case .Up:
            actionMove = SKAction.moveBy(CGVector(dx: 0, dy:  movement), duration: duration)
        case .Down:
            actionMove = SKAction.moveBy(CGVector(dx: 0, dy: -movement), duration: duration)
        }
        object.runAction(actionMove, completion: completion)
    }
    
    final func turnLeft(radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        turn(radius, duration: duration, left: true, completion: completion)
    }
    
    final func turnRight (radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        turn(radius, duration: duration, left: false, completion: completion)
    }
    
    private func turn(radius: CGFloat, duration: NSTimeInterval, left: Bool, completion: () -> Void) {
        let PI = CGFloat(M_PI)
        let actionRotate = SKAction.rotateByAngle(left ? PI/2 : -PI/2, duration: duration)
        var path: UIBezierPath
        var correctedPosition = object.position
        
        switch object.direction {
        case .Left :
            path = UIBezierPath(
                arcCenter: CGPointMake(0, left ? -radius : radius) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI/2) : PI*3/2,
                endAngle: PI,
                clockwise: left)
            correctedPosition.x += -radius
            correctedPosition.y += left ? -radius : radius
        case .Right:
            path = UIBezierPath(
                arcCenter: CGPointMake(0, left ? radius : -radius) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI*3/2) : PI/2,
                endAngle: 0,
                clockwise: left)
            correctedPosition.x += radius
            correctedPosition.y += left ? radius : -radius
        case .Up:
            path = UIBezierPath(
                arcCenter: CGPointMake(left ? -radius : radius, 0) ,
                radius: radius,
                startAngle: left ? 0 : PI,
                endAngle: PI/2,
                clockwise: left)
            correctedPosition.x += left ? -radius : radius
            correctedPosition.y += radius
        case .Down:
            path = UIBezierPath(
                arcCenter: CGPointMake(left ? radius : -radius, 0) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI) : 0,
                endAngle: PI*3/2,
                clockwise: left)
            correctedPosition.x += left ? radius : -radius
            correctedPosition.y += -radius
        }
        let actionMove: SKAction = SKAction.followPath(
            path.CGPath,
            asOffset: true,
            orientToPath: false,
            duration: duration)
        object.runAction(SKAction.group([actionRotate, actionMove]), completion: {
            [unowned object = self.object] in
            object.position = correctedPosition
            completion()
        })
    }
    
}
