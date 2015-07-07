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
        
        // Draw Grass
        for x in 0 ..< width {
            for y in 0  ..< height {
                if !mapArray[x][y] {
                    //addChild(Tile(Coordinates(x,y)))
                }
            }
        }
        
        // Interpret nodes in a 2D map
        for node in nodes {
            mapArray[node.coordinates.x][node.coordinates.y] = true
        }
        
        // Draw roads
        for node in nodes {
            var roadTile = Road.Builder(node: node).build()
            roadTile.position = node.position
            roadTile.zPosition = 0
            addChild(roadTile)
            if node.isDestination {
                var house: House
                if !node.direction.up && !mapArray[node.coordinates.x][node.coordinates.y+1] {
                    house = House(origin: Origin(node.coordinates.x, node.coordinates.y, CompassDirection.N))
                } else if !node.direction.right && !mapArray[node.coordinates.x+1][node.coordinates.y+1] {
                    house = House(origin: Origin(node.coordinates.x, node.coordinates.y, CompassDirection.E))
                } else if !node.direction.down && !mapArray[node.coordinates.x][node.coordinates.y-1] {
                    house = House(origin: Origin(node.coordinates.x, node.coordinates.y, CompassDirection.S))
                } else { //!node.direction.left && !mapArray[node.coordinates.x-1][node.coordinates.y]
                    house = House(origin: Origin(node.coordinates.x, node.coordinates.y, CompassDirection.W))
                }
                addChild(house)
            }
        }
        
        var cfc = CFC(origin: origin)
        addChild(cfc)
        addChild(player)
        
    }
    
}
