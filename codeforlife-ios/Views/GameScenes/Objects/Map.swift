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
    
    var width: Int
    var height: Int
    var nodes: [Node]
    var origin: Origin
    var destinations: [Node]
    var player: Van
    
    init(width: Int, height: Int, origin: Origin, nodes: [Node], destination: [Node]) {
        self.width = width
        self.height = height
        self.nodes = nodes
        self.origin = origin
        self.destinations = destination
        self.player = Van(origin: origin)
        self.player.zPosition = 1
        super.init(size: CGSize(
            width: GameMapConfig.Grid.width*CGFloat(width),
            height: GameMapConfig.Grid.height*CGFloat(height)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = kC4LGameMapGrassColor
    }
    
    func test3() {
        
        nodes.append(Node(Coordinates(5,5)))
        nodes.append(Node(Coordinates(5,6)))
        nodes.append(Node(Coordinates(5,7)))
        nodes.append(Node(Coordinates(4,6)))
        
        nodes[0].addConnectedNodeWithBackLink(nodes[1])
        nodes[1].addConnectedNodeWithBackLink(nodes[2])
        nodes[1].addConnectedNodeWithBackLink(nodes[3])
    }
    
    func draw() {
        self.removeAllChildren()
        for node in nodes {
            var roadTile = RoadTile.Builder(node: node).build()
            roadTile.position = node.position
            roadTile.zPosition = 0 
            addChild(roadTile)
            if node.isDestination {
                //TODO
            }
        }
        
        var cfc = CFC(origin: origin)
        addChild(cfc)
        addChild(player)
        
    }
    
}
