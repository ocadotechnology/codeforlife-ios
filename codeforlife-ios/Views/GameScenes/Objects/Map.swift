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
    
    override func didMoveToView(view: SKView) {
        backgroundColor = kC4LGameMapGrassColor
        self.scaleMode = SKSceneScaleMode.AspectFill
    }
    
    /// Reset Map array and Destinations.
    /// This should only be called before executing animations.
    func resetMap() {
        resetMapArray()
        resetDestination()
    }
    
    private func resetMapArray() {
        self.mapArray = [[Bool]]()
        for x in 0 ..< width {
            mapArray.append([Bool]())
            for y in 0  ..< height {
                mapArray[x].append(false)
            }
        }
        for node in nodes {
            mapArray[node.coordinates.x][node.coordinates.y] = true
        }
    }
    
    private func resetDestination() {
        for destination in destinations {
            destination.visited = false
        }
    }
    
    /// Returns TRUE if all destinations have been reached.
    func visitedAllDestinations() -> Bool {
        for destination in destinations {
            if !destination.visited {
                return false
            }
        }
        return true
    }
    
    func draw() {
        self.removeAllChildren()
        resetMap()
        drawGrass()
        drawRoads()
        drawDecorations()

        var cfc = CFC(origin: origin)
        addChild(cfc)
        
        addChild(player)
        
    }
    
    private func drawGrass() {
        for x in 0 ..< width {
            for y in 0  ..< height {
                if !mapArray[x][y] {
                    //addChild(Tile(Coordinates(x,y)))
                }
            }
        }
    }
    
    private func drawRoads() {
        for node in nodes {
            var roadTile = Road.Builder(node: node).build()
            roadTile.position = node.position
            roadTile.zPosition = 0
            addChild(roadTile)
            if node.isDestination {
                let origin = node.houseOrigin
                let house = House(origin: origin)
                addChild(house)
            }
        }
    }
    
    private func drawDecorations() {
        for decoration in decorations {
            addChild(decoration)
        }
    }
    
//    deinit { println("Map is being deallocated") }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
