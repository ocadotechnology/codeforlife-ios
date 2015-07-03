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
    
    let GRID_SPACE_SIZE: CGFloat = 60
    
    var width: Int
    var height: Int
    var nodes = [Node]()
    var destinations = [Node]()
    var player = Van.Builder(width: 20, height: 40, rad: 0).build()
    
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
        backgroundColor = kC4LGameMapGrassColor
        
        //test
        nodes.append(Node(Coordinates(0,5)))
        nodes.append(Node(Coordinates(1,5)))
        nodes.append(Node(Coordinates(2,5)))
        nodes.append(Node(Coordinates(2,4)))
        nodes.append(Node(Coordinates(2,3)))
        nodes.append(Node(Coordinates(2,2)))
        nodes.append(Node(Coordinates(1,2)))
        nodes.append(Node(Coordinates(3,2)))
        
        nodes[0].addConnectedNodeWithBackLink(nodes[1])
        nodes[1].addConnectedNodeWithBackLink(nodes[2])
        nodes[2].addConnectedNodeWithBackLink(nodes[3])
        nodes[3].addConnectedNodeWithBackLink(nodes[4])
        nodes[4].addConnectedNodeWithBackLink(nodes[5])
        nodes[5].addConnectedNodeWithBackLink(nodes[6])
        nodes[5].addConnectedNodeWithBackLink(nodes[7])
    }
    
    func draw() {
        
        for node in nodes {
            var roadTile = node.toRoadTile()
            roadTile.position = CGPoint(
                x: CGFloat(node.coordinates.x)*GameMapConfig.Grid.width + GameMapConfig.Grid.width/2,
                y: CGFloat(node.coordinates.y)*GameMapConfig.Grid.height + GameMapConfig.Grid.height/2)
            addChild(roadTile)
        }
        
        player.position = CGPoint(x: frame.size.width*0.5, y: frame.size.height*0.5)
        addChild(player)
        player.rotate(CGFloat(M_PI/2))

    }
    
}
