//
//  MovableGameObject.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit


class MovableGameObject: GameObject {
    
    let PI = CGFloat(M_PI)
    
    var direction : Direction
    var origin: Origin
    
    init(imageNamed: String, width: CGFloat, height: CGFloat, origin : Origin) {
        self.direction = origin.compassDirection.direction
        self.origin = origin
        super.init(imageNamed: imageNamed, width: width, height: height)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetPosition() {
        fatalError("Implement resetPosition()")
    }
    
    func moveForward(movement: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        var actionMove: SKAction
        switch direction {
        case .Left :
            actionMove = SKAction.moveBy(CGVector(dx: -movement, dy: 0), duration: duration)
        case .Right:
            actionMove = SKAction.moveBy(CGVector(dx:  movement, dy: 0), duration: duration)
        case .Up:
            actionMove = SKAction.moveBy(CGVector(dx: 0, dy:  movement), duration: duration)
        case .Down:
            actionMove = SKAction.moveBy(CGVector(dx: 0, dy: -movement), duration: duration)
        }
        self.runAction(actionMove, completion: completion)
    }
    
    func turnLeft(radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        turn(radius, duration: duration, left: true, completion: completion)
    }
    
    func turnRight (radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        turn(radius, duration: duration, left: false, completion: completion)
    }
    
    private func turn(radius: CGFloat, duration: NSTimeInterval, left: Bool, completion: () -> Void) {
        let actionRotate = SKAction.rotateByAngle(left ? PI/2 : -PI/2, duration: duration)
        var path: UIBezierPath
        var correctedPosition = self.position
        
        switch direction {
        case .Left :
            path = UIBezierPath(
                arcCenter: CGPointMake(0, left ? -radius : radius) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI/2) : PI*3/2,
                endAngle: PI,
                clockwise: left)
            direction = left ? .Down : .Up
            correctedPosition.x += -radius
            correctedPosition.y += left ? -radius : radius
        case .Right:
            path = UIBezierPath(
                arcCenter: CGPointMake(0, left ? radius : -radius) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI*3/2) : PI/2,
                endAngle: 0,
                clockwise: left)
            direction = left ? .Up : .Down
            correctedPosition.x += radius
            correctedPosition.y += left ? radius : -radius
        case .Up:
            path = UIBezierPath(
                arcCenter: CGPointMake(left ? -radius : radius, 0) ,
                radius: radius,
                startAngle: left ? 0 : PI,
                endAngle: PI/2,
                clockwise: left)
            direction = left ? .Left : .Right
            correctedPosition.x += left ? -radius : radius
            correctedPosition.y += radius
        case .Down:
            path = UIBezierPath(
                arcCenter: CGPointMake(left ? radius : -radius, 0) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI) : 0,
                endAngle: PI*3/2,
                clockwise: left)
            direction = left ? .Right : .Left
            correctedPosition.x += left ? radius : -radius
            correctedPosition.y += -radius
        }
        let actionMove: SKAction = SKAction.followPath(
            path.CGPath,
            asOffset: true,
            orientToPath: false,
            duration: duration)
        self.runAction(SKAction.group([actionRotate, actionMove]), completion: {
                self.position = correctedPosition
                completion()
            })
    }
    
    func moveForward(_ completion : (() -> Void)? = nil) {
        fatalError("Implement moveForward()")
    }
    
    func turnLeft(_ completion : (() -> Void)? = nil) {
        fatalError("Implement turnLeft()")
    }
    
    func turnRight(_ completion : (() -> Void)? = nil) {
        fatalError("Implement turnRight()")
    }
    
}
