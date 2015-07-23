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

    var currentCoordinates: Coordinates
    var direction : Direction
    var origin: Origin
    
    var crashed: Bool {
        let mapArray = SharedContext.MainGameViewController!.gameMapViewController!.map!.mapArray
        return !mapArray[currentCoordinates.x][currentCoordinates.y]
    }
    
    init(imageNamed: String, width: CGFloat, height: CGFloat, origin : Origin) {
        self.direction = origin.compassDirection.direction
        self.origin = origin
        self.currentCoordinates = origin.coordinates
        super.init(imageNamed: imageNamed, width: width, height: height)
    }

    
    func reset() {
        removeAllActions()
        resetCurrentCoordinates()
        updatePosition()
    }
    
    func resetCurrentCoordinates() {
        self.currentCoordinates = self.origin.coordinates
    }
    
    func updatePosition() {
        self.position = CGPointMake(
            CGFloat(currentCoordinates.x) * GameMapConfig.GridSize.width + GameMapConfig.GridSize.width/2 + GameMapConfig.MapXOffset,
            CGFloat(currentCoordinates.y) * GameMapConfig.GridSize.height + GameMapConfig.GridSize.height/2 + GameMapConfig.MapYOffset)
        self.direction = origin.compassDirection.direction
        let actionRotate = SKAction.rotateToAngle(origin.compassDirection.angle, duration: 0)
        self.runAction(actionRotate)
    }
    
    /*************
     * Movements *
     *************/
    func moveForward(#animated: Bool, completion : (() -> Void)?) {
        moveForwardAnimation(
            movement: GameMapConfig.GridSize,
            duration: animated ? 0.5 : 0,
            completion: {
                [unowned self] in
                self.updatePosition()
                completion?()
        })
        switch self.direction {
        case .Left :    self.currentCoordinates.x--
        case .Right:    self.currentCoordinates.x++
        case .Up:       self.currentCoordinates.y++
        case .Down:     self.currentCoordinates.y--
        }
    }
    
    func turnLeft(#animated: Bool, completion : (() -> Void)?) {
        turnLeftAnimation(
            radius: GameMapConfig.GridSize.height*(33+24+22)/202,
            duration: animated ? 0.5 : 0,
            completion: {
                [unowned self] in
                self.updatePosition()
                completion?()
            })
        self.turn(left: true)
    }
    
    func turnRight(#animated: Bool, completion : (() -> Void)?) {
        turnRightAnimation(
            radius: GameMapConfig.GridSize.height*(33+24+44+22)/202,
            duration: animated ? 0.5 : 0,
            completion: {
                [unowned self] in
                self.updatePosition()
                completion?()
        })
        self.turn(left: false)
    }
    
    
    
    
    
    
    
    
    private func moveForwardAnimation(#movement: CGSize, duration: NSTimeInterval, completion: () -> Void) {
        var actionMove: SKAction
        switch direction {
        case .Left :
            actionMove = SKAction.moveBy(CGVector(dx: -movement.width, dy: 0), duration: duration)
        case .Right:
            actionMove = SKAction.moveBy(CGVector(dx:  movement.width, dy: 0), duration: duration)
        case .Up:
            actionMove = SKAction.moveBy(CGVector(dx: 0, dy:  movement.height), duration: duration)
        case .Down:
            actionMove = SKAction.moveBy(CGVector(dx: 0, dy: -movement.height), duration: duration)
        }
        runAction(actionMove, completion: completion)
    }
    
    private func turn(#left: Bool) {
        switch direction {
            case .Left:     direction = left ? .Down : .Up
                            currentCoordinates.y += left ? -1 : +1
            case .Right:    direction = left ? .Up : .Down
                            currentCoordinates.y += left ? 1 : -1
            case .Up:       direction = left ? .Left : .Right
                            currentCoordinates.x += left ? -1 : 1
            case .Down:     direction = left ? .Right : .Left
                            currentCoordinates.x += left ? 1 : -1
        }
    }
    
    private func turnLeftAnimation(#radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        turnAnimation(radius, duration, left: true, completion)
    }
    
    private func turnRightAnimation (#radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        turnAnimation(radius, duration, left: false, completion)
    }
    
    private func turnAnimation(radius: CGFloat, _ duration: NSTimeInterval, left: Bool, _ completion: () -> Void) {
        let PI = CGFloat(M_PI)
        let actionRotate = SKAction.rotateByAngle(left ? PI/2 : -PI/2, duration: duration)
        var path: UIBezierPath
        
        switch direction {
        case .Left :
            path = UIBezierPath(
                arcCenter: CGPointMake(0, left ? -radius : radius) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI/2) : PI*3/2,
                endAngle: PI,
                clockwise: left)
        case .Right:
            path = UIBezierPath(
                arcCenter: CGPointMake(0, left ? radius : -radius) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI*3/2) : PI/2,
                endAngle: 0,
                clockwise: left)
        case .Up:
            path = UIBezierPath(
                arcCenter: CGPointMake(left ? -radius : radius, 0) ,
                radius: radius,
                startAngle: left ? 0 : PI,
                endAngle: PI/2,
                clockwise: left)
        case .Down:
            path = UIBezierPath(
                arcCenter: CGPointMake(left ? radius : -radius, 0) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI) : 0,
                endAngle: PI*3/2,
                clockwise: left)
        }
        let actionMove: SKAction = SKAction.followPath(
            path.CGPath,
            asOffset: true,
            orientToPath: false,
            duration: duration)
        runAction(SKAction.group([actionRotate, actionMove]), completion: {
            completion()
            })
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
