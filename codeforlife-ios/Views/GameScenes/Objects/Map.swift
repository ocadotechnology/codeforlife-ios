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
    var van: Van
    lazy var mapArray = [[Bool]]()
    let originalSize: CGSize
    
    init(width: Int, height: Int, origin: Origin, nodes: [Node], destination: [Destination], decorations: [Decoration]) {
        self.width = width
        self.height = height
        self.nodes = nodes
        self.origin = origin
        self.destinations = destination
        self.decorations = decorations
        self.van = Van(origin: origin)
        self.van.zPosition = 0.8
        self.originalSize = CGSizeMake(
            GameMapConfig.GridSize.width*CGFloat(width),
            GameMapConfig.GridSize.height*CGFloat(height))
        super.init(size: originalSize)
    }
    
    override func didMoveToView(view: SKView) {
        self.scaleMode = SKSceneScaleMode.AspectFill
    }
    
    final func resetMap() {
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
    
    func allDestinationVisited() -> Bool {
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
        drawBorders()
        drawDecorations()

        var cfc = CFC(origin: origin)
        addChild(cfc)
        addChild(van)
    }
    
    private func drawGrass() {
        for x in 0 ..< width {
            for y in 0  ..< height {
                if x%2 == 0 && y%2 == 0 {
                    addChild(Tile(Coordinates(x,y)))
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
    
    private func drawBorders() {
        for destination in destinations {
            addChild(destination.createBorder())
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
