//
//  WorldNode.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

public class WorldNode: SKNode {
    
    func drawBorders(destinations: [Destination]) {
        destinations.foreach({[unowned self] in self.addChild($0.border)})
    }
    
    func buildRoads(nodes: [Node]) {
        nodes.foreach({[unowned self] in self.addChild(Road.Builder(node: $0).build())})
    }
    
    func buildHouses(nodes: [Node]) {
        nodes.filter({$0.isDestination})
            .foreach({
                [unowned self] in
                self.addChild(House(node: $0))
            })
    }
    
    func buildGrass(width: Int, _ height: Int) {
        for x in -4 ..< width + 4 {
            for y in -4  ..< height + 4 {
                if x%2 == 0 && y%2 == 0 {
                    addChild(Tile(Coordinates(x,y)))
                }
            }
        }
    }
    
    func buildDecorations(decorations: [Decoration]) {
        decorations.foreach({[unowned self] in self.addChild($0)})
    }
    
    func buildCFC(origin: Origin) {
        self.addChild(CFC(origin: origin))
    }
    
    func prepareVan(origin: Origin) -> Van {
        let van = Van(origin: origin)
        van.zPosition = 0.8
        addChild(van)
        return van
    }
    
}
