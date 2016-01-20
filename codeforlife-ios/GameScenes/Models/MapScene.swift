//
//  Map.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SpriteKit

public class MapScene: SKScene {
    
    let width: Int                      /* Number of columns in the map grid */
    let height: Int                     /* Number of rows in the map grid */
    
    let nodes: [Node]                   /* See @Node */
    let origin: Origin                  /* Origin node */
    let destinations: [Destination]     /* Destination nodes */
    let decorations: [Decoration]       /* See @Decoration */
    lazy var mapArray = [[Bool]]()      /* 2D array to simulate the map */
    
    let van: Van                        /* Object representing the player */
    
    let world: WorldNode                /* Node to represent the world */
    let kamera: SKNode                  /* Node to represent the camera in the world */
    
    weak var delegate2: GameViewControllerDelegate?
    
    init(delegate: GameViewControllerDelegate?, width: Int, height: Int, origin: Origin, nodes: [Node], destination: [Destination], decorations: [Decoration]) {
        self.delegate2 = delegate
        self.width = width
        self.height = height
        self.origin = origin
        self.nodes = nodes
        self.destinations = destination
        self.decorations = decorations
        self.world = WorldNode()
        self.kamera = SKNode()
        self.van = world.prepareVan(origin)
    
        let sceneWidth = GameMapConfig.GridSize.width*CGFloat(width) + GameMapConfig.MapOffset.x
        let sceneHeight = GameMapConfig.GridSize.height*CGFloat(height) + GameMapConfig.MapOffset.y
        super.init(size: CGSizeMake(sceneWidth, sceneHeight))
        setupWorld()
    }
    
    func allDestinationsVisited() -> Bool {
        return destinations.filter({!$0.visited}).count > 0
    }
    
    func resetMap() {
        // Rebuild all the roads
        self.mapArray = buildMapArray(width, height)
        nodes.foreach({[unowned self] in self.mapArray[$0.coordinates.x][$0.coordinates.y] = true})
        
        // Unvisit all the destinations
        destinations.foreach({$0.visited = false})
    }
    
    func centerOnNode(node: SKNode) {
        if let cameraNodeParent = node.parent,
            cameraPositionInScene = node.scene?.convertPoint(node.position, fromNode: cameraNodeParent) {
                cameraNodeParent.position = CGPointMake(cameraNodeParent.position.x - cameraPositionInScene.x, cameraNodeParent.position.y - cameraPositionInScene.y)
        }
    }
    
    func constructWorld() {
        self.backgroundColor = kC4LGameMapGrassColor
        self.removeAllChildren()
        self.resetMap()
        self.addChild(world)
        world.buildGrass(width, height)
        world.buildRoads(nodes)
        world.buildHouses(nodes)
        world.buildDecorations(decorations)
        world.buildCFC(origin)
        world.drawBorders(destinations)
    }
    
    private func setupWorld() {
        
        self.addChild(world)
        world.addChild(kamera)
        
        // Center camera
        self.anchorPoint = CGPointMake(0.5, 0.5)
        kamera.position = CGPointMake(size.width/2, size.height/2)
        self.centerOnNode(kamera)
    }
    
    private func buildMapArray(width: Int, _ height: Int) -> [[Bool]] {
        var mapArray = [[Bool]]()
        for x in 0 ..< width {
            mapArray.append([Bool]())
            for _ in 0  ..< height {
                mapArray[x].append(false)
            }
        }
        return mapArray
    }
    
    override public func didMoveToView(view: SKView) {
        self.scaleMode = SKSceneScaleMode.AspectFill
    }
    
    override public func didFinishUpdate() {
        delegate2?.centerOnNodeDuringAnimation(van, completion: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    deinit { println("Map is being deallocated") }
    
}
