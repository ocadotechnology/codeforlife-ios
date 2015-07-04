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
    var nodes = [Node]()
    var destinations = [Node]()
    var player = Van.Builder(width: GameMapConfig.Grid.width*38/202, height: GameMapConfig.Grid.width*38/202*510/264, rad: 0).build()
    
    init(width: Int, height: Int, size: CGSize) {
        self.width = width
        self.height = height
        super.init(size: CGSize(
            width: GameMapConfig.Grid.width*CGFloat(width),
            height: GameMapConfig.Grid.height*CGFloat(height)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = kC4LGameMapGrassColor
        
        test1()
    }
    
    func test1() {
        nodes.append(Node(Coordinates(0,5)))
        nodes.append(Node(Coordinates(1,5)))
        nodes.append(Node(Coordinates(2,5)))
        nodes.append(Node(Coordinates(2,4)))
        nodes.append(Node(Coordinates(2,3)))
        nodes.append(Node(Coordinates(2,2)))
        nodes.append(Node(Coordinates(3,2)))
        nodes.append(Node(Coordinates(4,2)))
        nodes.append(Node(Coordinates(4,3)))
        nodes.append(Node(Coordinates(4,4)))
        nodes.append(Node(Coordinates(5,4)))
        nodes.append(Node(Coordinates(6,4)))
        nodes.append(Node(Coordinates(6,5)))
        
        for index in 1 ..< nodes.count {
            nodes[index-1].addConnectedNodeWithBackLink(nodes[index])
        }
    }
    
    func test2() {
        nodes.append(Node(Coordinates(8,5)))
        nodes.append(Node(Coordinates(7,5)))
        nodes.append(Node(Coordinates(7,4)))
        nodes.append(Node(Coordinates(7,3)))
        nodes.append(Node(Coordinates(6,3)))
        nodes.append(Node(Coordinates(5,3)))
        nodes.append(Node(Coordinates(5,4)))
        nodes.append(Node(Coordinates(5,5)))
        nodes.append(Node(Coordinates(4,5)))
        nodes.append(Node(Coordinates(3,5)))
        
        for index in 1 ..< nodes.count {
            nodes[index-1].addConnectedNodeWithBackLink(nodes[index])
        }
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
        
        for node in nodes {
            var roadTile = RoadTile.Builder(node: node).build()
            roadTile.position = node.position
            addChild(roadTile)
            println(node.position)
        }
        
        player.position = CGPointMake(
        CGFloat(nodes[0].coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.Grid.height/2,
        CGFloat(nodes[0].coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + player.width/2 + 1.5)
        addChild(player)
        player.rotate(CGFloat(M_PI/2))

    }
    
}
