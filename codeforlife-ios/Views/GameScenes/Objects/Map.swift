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
    var destinations: [Destination]
    var decorations: [Decoration]
    var player: Van
    lazy var mapArray = [[Bool]]()
    
    init(width: Int, height: Int, origin: Origin, nodes: [Node], destination: [Destination], decorations: [Decoration]) {
        self.width = width
        self.height = height
        self.nodes = nodes
        self.origin = origin
        self.destinations = destination
        self.decorations = decorations
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
        for destination in destinations {
            destination.visited = false
        }
    }
    
    func visitedAllDestinations() -> Bool {
        for destination in destinations {
            if !destination.visited {
                return false
            }
        }
        return true
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
                var compassDirection = CompassDirection.N
                if node.connectedNodes.count == 2 &&
                    !(node.direction.up && node.direction.down) &&
                    !(node.direction.left && node.direction.right) {
                    if !node.direction.up && !node.direction.right {
                        compassDirection = CompassDirection.NE
                    } else if !node.direction.up && !node.direction.left {
                        compassDirection = CompassDirection.NW
                    } else if !node.direction.right && !node.direction.down {
                        compassDirection = CompassDirection.SE
                    } else { //!node.direction.down && !node.direction.left
                        compassDirection = CompassDirection.SW
                    }
                } else {
                    if !node.direction.up {
                        compassDirection = CompassDirection.N
                    } else if !node.direction.right {
                        compassDirection = CompassDirection.E
                    } else if !node.direction.down {
                        compassDirection = CompassDirection.S
                    } else { //!node.direction.left
                        compassDirection = CompassDirection.W
                    }
                }
                let origin = Origin(node.coordinates, compassDirection)
                let house = House(origin: origin)
                addChild(house)
            }
        }
        
        for decoration in decorations {
            addChild(decoration)
        }
        
        var cfc = CFC(origin: origin)
        addChild(cfc)
        addChild(player)
        
    }
    
    deinit {
        println("Map is being deallocated")
    }
    
}
