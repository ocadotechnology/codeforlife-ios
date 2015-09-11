//
//  Destination.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation

// This cannot be struct for some reason, probably because I want to change the value of visited
public class Destination {
    
    let coordinates: Coordinates
    let border: SKShapeNode
    var visited: Bool = false { didSet { border.strokeColor = visited ? UIColor.greenColor() : UIColor.redColor() } }
    
    init(_ coordinates: Coordinates) {
        self.coordinates = coordinates
        self.visited = false
        
        let xPosition = CGFloat(coordinates.x) * GameMapConfig.GridSize.width + GameMapConfig.MapOffset.x
        let yPosition = CGFloat(coordinates.y) * GameMapConfig.GridSize.height + GameMapConfig.MapOffset.y
        self.border = SKShapeNode(rect: CGRect(origin: CGPointMake(xPosition, yPosition), size: GameMapConfig.GridSize))
        self.border.lineWidth = 2
        self.border.strokeColor = UIColor.redColor()
        self.border.zPosition = 0.5
    }
    
    convenience init(_ x: Int, _ y: Int) {
        self.init(Coordinates(x, y))
    }
    
}