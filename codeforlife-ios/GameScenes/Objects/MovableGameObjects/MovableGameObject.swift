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
    let origin: Origin
    
    var crashed: Bool {
        let mapArray = (scene as! MapScene).mapArray
        return !mapArray[currentCoordinates.x][currentCoordinates.y]
    }
    
    init(imageNamed: String, width: CGFloat, height: CGFloat, origin : Origin) {
        self.direction = origin.compassDirection.direction
        self.origin = origin
        self.currentCoordinates = origin.coordinates
        super.init(imageNamed: imageNamed, width: width, height: height, rotation: 0)
    }

    func reset() {
        removeAllActions()
        resetCurrentCoordinates()
        updatePosition()
    }
    
    final func resetCurrentCoordinates() {
        self.currentCoordinates = self.origin.coordinates
        self.direction = self.origin.compassDirection.direction
        handleResetCurrentCoordinatesOffset()
    }
    
    /// Handle the offset in addition to the original resetCurrentCoordinates function
    /// to handle current coordinates reset for different kind of game objects
    func handleResetCurrentCoordinatesOffset() {}
    
    final func updatePosition() {
        self.position = currentCoordinates.toMapPosition()
        handleUpdatePositionOffset()
        let actionRotate = SKAction.rotateToAngle(direction.compassDirection.angle, duration: 0)
        self.runAction(actionRotate)
    }
    
    /// Handle the offset in addition to the original updatePosition function to
    /// handle position update for different kind of game objects
    func handleUpdatePositionOffset() {}
    
    
    /*************
     * Movements *
     *************/
    func moveForward(#animated: Bool, completion : (() -> Void)?) {
        moveForwardWithAnimation(
            movement: GameMapConfig.GridSize,
            duration: animated ? 0.5 : 0,
            completion: {
                [unowned self] in
                self.updatePosition()
                completion?()
        })
    }
    
    func turnLeft(#animated: Bool, completion : (() -> Void)?) {
        turnLeftWithAnimation(
            radius: GameMapConfig.GridSize.height*(33+24+22)/202,
            duration: animated ? 0.5 : 0,
            completion: {
                [unowned self] in
                self.updatePosition()
                completion?()
            })
    }
    
    func turnRight(#animated: Bool, completion : (() -> Void)?) {
        turnRightWithAnimation(
            radius: GameMapConfig.GridSize.height*(33+24+44+22)/202,
            duration: animated ? 0.7 : 0,
            completion: {
                [unowned self] in
                self.updatePosition()
                completion?()
        })
    }
    

    /********************
     * Helper Functions *
     ********************/
    private final func moveForwardWithAnimation(#movement: CGSize, duration: NSTimeInterval, completion: () -> Void) {
        var actionMove: SKAction
        switch direction {
        case .Left :
            actionMove = SKAction.moveBy(CGVector(dx: -movement.width, dy: 0), duration: duration)
            currentCoordinates.x--
        case .Right:
            actionMove = SKAction.moveBy(CGVector(dx:  movement.width, dy: 0), duration: duration)
            currentCoordinates.x++
        case .Up:
            actionMove = SKAction.moveBy(CGVector(dx: 0, dy:  movement.height), duration: duration)
            currentCoordinates.y++
        case .Down:
            actionMove = SKAction.moveBy(CGVector(dx: 0, dy: -movement.height), duration: duration)
            currentCoordinates.y--
        }
        runAction(actionMove, completion: completion)
    }
    
    private final func turnLeftWithAnimation(#radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        turnWithAnimation(radius, duration, left: true, completion)
    }
    
    private final func turnRightWithAnimation(#radius: CGFloat, duration: NSTimeInterval, completion: () -> Void) {
        turnWithAnimation(radius, duration, left: false, completion)
    }
    
    private final func turnWithAnimation(radius: CGFloat, _ duration: NSTimeInterval, left: Bool, _ completion: () -> Void) {
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
            direction = left ? .Down : .Up
            currentCoordinates.y += left ? -1 : +1
        case .Right:
            path = UIBezierPath(
                arcCenter: CGPointMake(0, left ? radius : -radius) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI*3/2) : PI/2,
                endAngle: 0,
                clockwise: left)
            direction = left ? .Up : .Down
            currentCoordinates.y += left ? 1 : -1
        case .Up:
            path = UIBezierPath(
                arcCenter: CGPointMake(left ? -radius : radius, 0) ,
                radius: radius,
                startAngle: left ? 0 : PI,
                endAngle: PI/2,
                clockwise: left)
            direction = left ? .Left : .Right
            currentCoordinates.x += left ? -1 : 1
        case .Down:
            path = UIBezierPath(
                arcCenter: CGPointMake(left ? radius : -radius, 0) ,
                radius: radius,
                startAngle: left ? CGFloat(M_PI) : 0,
                endAngle: PI*3/2,
                clockwise: left)
            direction = left ? .Right : .Left
            currentCoordinates.x += left ? 1 : -1
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
