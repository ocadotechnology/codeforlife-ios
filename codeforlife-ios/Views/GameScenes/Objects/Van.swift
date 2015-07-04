//
//  Player.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class Van: GameObject {
    
    let PI = CGFloat(M_PI)
    
    enum Direction {
        case Left
        case Right
        case Up
        case Down
    }
    
    class Builder {
    
        private var angle: CGFloat
        private var height: CGFloat
        private var width: CGFloat
        
        init (width: CGFloat, height: CGFloat, rad: CGFloat) {
            self.angle = rad
            self.height = height
            self.width = width
        }
        
        func build() -> Van {
            var van = Van(builder: self)
            van.rotate(angle)
            return van
        }
        
    }
    
    var direction = Direction.Right
    
    private init(builder: Van.Builder) {
        super.init(imageNamed: "ocadoVan_big", width: builder.width, height: builder.height)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let actionRotate = SKAction.rotateByAngle(PI/2, duration: duration)
        var path: UIBezierPath

        switch direction {
            case .Left :
                path = UIBezierPath(
                        arcCenter: CGPointMake(0, -radius) ,
                        radius: radius,
                        startAngle: PI/2,
                        endAngle: PI,
                        clockwise: true)
                direction = .Down
            case .Right:
                path = UIBezierPath(
                    arcCenter: CGPointMake(0, radius) ,
                    radius: radius,
                    startAngle: PI*3/2,
                    endAngle: 0,
                    clockwise: true)
                direction = .Up
            case .Up:
                path = UIBezierPath(
                    arcCenter: CGPointMake(-radius, 0) ,
                    radius: radius,
                    startAngle: 0,
                    endAngle: PI/2,
                    clockwise: true)
                direction = .Left
            case .Down:
                path = UIBezierPath(
                    arcCenter: CGPointMake(radius, 0) ,
                    radius: radius,
                    startAngle: PI,
                    endAngle: PI*3/2,
                    clockwise: true)
                direction = .Right
        }
        let actionMove: SKAction = SKAction.followPath(
                                                path.CGPath,
                                                asOffset: true,
                                                orientToPath: false,
                                                duration: duration)
        self.runAction(SKAction.group([actionRotate, actionMove]), completion: completion)
    }
    
    func turnRight (radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        let actionRotate = SKAction.rotateByAngle(-PI/2, duration: duration)
        var path: UIBezierPath
        
        switch direction {
            case .Left :
                path = UIBezierPath(
                    arcCenter: CGPointMake(0, radius) ,
                    radius: radius,
                    startAngle: PI*3/2,
                    endAngle: PI,
                    clockwise: false)
                direction = .Up
            case .Right:
                path = UIBezierPath(
                    arcCenter: CGPointMake(0, -radius) ,
                    radius: radius,
                    startAngle: PI/2,
                    endAngle: 0,
                    clockwise: false)
                direction = .Down
            case .Up:
                path = UIBezierPath(
                    arcCenter: CGPointMake(radius, 0) ,
                    radius: radius,
                    startAngle: PI,
                    endAngle: PI/2,
                    clockwise: false)
                direction = .Right
            case .Down:
                path = UIBezierPath(
                    arcCenter: CGPointMake(-radius, 0) ,
                    radius: radius,
                    startAngle: 0,
                    endAngle: PI*3/2,
                    clockwise: false)
                direction = .Left
        }
        let actionMove: SKAction = SKAction.followPath(
            path.CGPath,
            asOffset: true,
            orientToPath: false,
            duration: duration)
        self.runAction(SKAction.group([actionRotate, actionMove]), completion: completion)
    }
    
}
