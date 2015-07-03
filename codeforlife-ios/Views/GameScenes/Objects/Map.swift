//
//  Map.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SpriteKit

class Map: SKScene {
    
    let GRID_SPACE_SIZE: CGFloat = 50
    
    var width: Int
    var height: Int
    var nodes = [Node]()
    var origin = Node
    var destinations = [Node]()
    var player = Van()
    
    init(width: Int, height: Int, size: CGSize) {
        self.width = width
        self.height = height
        super.init(size: CGSize(
            width: GRID_SPACE_SIZE*CGFloat(width),
            height: GRID_SPACE_SIZE*CGFloat(height)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blueColor()
        
    }
    
    func draw() {
        
        for node in nodes {
            var ground = GridObject("ocadoVan_big")
            ground.position = CGPoint(
                x: CGFloat(node.coordinates.x)*50 + 25,
                y: CGFloat(node.coordinates.y)*50 + 25)
            addChild(ground)
        }
        
        player.position = CGPoint(x: frame.size.width*0.5, y: frame.size.height*0.5)
        addChild(player)
        player.rotate(CGFloat(M_PI/2))

    }
    
}
