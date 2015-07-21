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
            CGFloat(currentCoordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.MapXOffset,
            CGFloat(currentCoordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + GameMapConfig.MapYOffset)
        self.direction = origin.compassDirection.direction
        let actionRotate = SKAction.rotateToAngle(origin.compassDirection.angle, duration: 0)
        self.runAction(actionRotate)
    }
    
    
    
    /*************
     * Movements *
     *************/
    func moveForward() {
        switch direction {
            case .Left :    currentCoordinates.x--
            case .Right:    currentCoordinates.x++
            case .Up:       currentCoordinates.y++
            case .Down:     currentCoordinates.y--
        }
    }
    
    func turnLeft() {
        turn(left: true)
    }
    
    func turnRight() {
        turn(left: false)
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
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
