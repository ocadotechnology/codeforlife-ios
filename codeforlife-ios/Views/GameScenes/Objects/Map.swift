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
    var mapArray = [[Bool]]()
    
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
    
    func resetMap() {
        self.removeAllChildren()
        self.mapArray = [[Bool]]()
        for x in 0 ..< width {
            mapArray.append([Bool]())
            for y in 0  ..< height {
                mapArray[x].append(false)
            }
        }
    }
    
    func draw() {
        resetMap()
        
        for node in nodes {
            mapArray[node.coordinates.x][node.coordinates.y] = true
        }
        
        for node in nodes {
            var roadTile = RoadTile.Builder(node: node).build()
            roadTile.position = node.position
            roadTile.zPosition = 0
            addChild(roadTile)
            if node.isDestination {
                var house: House
                if !node.direction.up && !mapArray[node.coordinates.x][node.coordinates.y+1] {
                    house = House(origin: Origin(node.coordinates.x, node.coordinates.y, CompassDirection.N))
                    println("N")
                } else if !node.direction.right && !mapArray[node.coordinates.x+1][node.coordinates.y+1] {
                    house = House(origin: Origin(node.coordinates.x, node.coordinates.y, CompassDirection.E))
                    println("e")
                } else if !node.direction.down && !mapArray[node.coordinates.x][node.coordinates.y-1] {
                    house = House(origin: Origin(node.coordinates.x, node.coordinates.y, CompassDirection.S))
                    println("s")
                } else { //!node.direction.left && !mapArray[node.coordinates.x-1][node.coordinates.y]
                    house = House(origin: Origin(node.coordinates.x, node.coordinates.y, CompassDirection.W))
                    println("w")
                }
                addChild(house)
            }
        }
        
        var cfc = CFC(origin: origin)
        addChild(cfc)
        addChild(player)
        
    }
    
}
