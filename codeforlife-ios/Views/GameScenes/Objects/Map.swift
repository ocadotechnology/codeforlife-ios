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
//        nodes.append(Node(Coordinates(7,3)))
//        nodes.append(Node(Coordinates(6,3)))
//        nodes.append(Node(Coordinates(5,3)))
//        nodes.append(Node(Coordinates(5,4)))
//        nodes.append(Node(Coordinates(5,5)))
//        nodes.append(Node(Coordinates(4,5)))
//        nodes.append(Node(Coordinates(3,5)))
        
        for index in 1 ..< nodes.count {
            nodes[index-1].addConnectedNodeWithBackLink(nodes[index])
        }
    }
    
    func draw() {
        
        for node in nodes {
            var roadTile = RoadTile.Builder(node: node).build()
            roadTile?.position = node.position
            if roadTile != nil {
                addChild(roadTile!)
            }
            println((node.position, node.height, node.width))
        }
        
        player.position = CGPoint(x: frame.size.width*0.5, y: frame.size.height*0.5)
        addChild(player)
        player.rotate(CGFloat(M_PI/2))

    }
    
}
