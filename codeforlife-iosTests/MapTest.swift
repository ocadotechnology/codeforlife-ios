//
//  MapTest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 07/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class MapTest: XCTestCase {
    
    var nodes = [Node]()

    override func setUp() {
        super.setUp()
        nodes = [Node]()
    }

    func testRoadTilePosition1() {
        
        nodes.append(Node(Coordinates(0,5))) //0
        nodes.append(Node(Coordinates(1,5)))
        nodes.append(Node(Coordinates(2,5)))
        nodes.append(Node(Coordinates(2,4)))
        nodes.append(Node(Coordinates(2,3)))
        nodes.append(Node(Coordinates(2,2))) //5
        nodes.append(Node(Coordinates(3,2)))
        nodes.append(Node(Coordinates(4,2)))
        nodes.append(Node(Coordinates(4,3)))
        nodes.append(Node(Coordinates(4,4)))
        nodes.append(Node(Coordinates(5,4))) //10
        nodes.append(Node(Coordinates(6,4)))
        nodes.append(Node(Coordinates(6,5)))
        
        for index in 1 ..< nodes.count {
            nodes[index-1].addConnectedNodeWithBackLink(nodes[index])
        }
        
        XCTAssertEqual(nodes[0].position, toNormalPoint(nodes[0], RoadType.DeadEnd.offset, 0), "")
        XCTAssertEqual(nodes[1].position, toNormalPoint(nodes[1], 0, 0), "")
        XCTAssertEqual(nodes[2].position, toNormalPoint(nodes[2], -RoadType.Turn.offset, -RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[3].position, toNormalPoint(nodes[3], 0, 0), "")
        XCTAssertEqual(nodes[4].position, toNormalPoint(nodes[4], 0, 0), "")
        XCTAssertEqual(nodes[5].position, toNormalPoint(nodes[5], RoadType.Turn.offset, RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[6].position, toNormalPoint(nodes[6], 0, 0), "")
        XCTAssertEqual(nodes[7].position, toNormalPoint(nodes[7], -RoadType.Turn.offset, RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[8].position, toNormalPoint(nodes[8], 0, 0), "")
        XCTAssertEqual(nodes[9].position, toNormalPoint(nodes[9], +RoadType.Turn.offset, -RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[10].position, toNormalPoint(nodes[10], 0, 0), "")
        XCTAssertEqual(nodes[11].position, toNormalPoint(nodes[11], -RoadType.Turn.offset, +RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[12].position, toNormalPoint(nodes[12], 0, -RoadType.DeadEnd.offset), "")
    }
    
    func testRoadTilePosition2() {
        
        nodes.append(Node(Coordinates(8,5))) //0
        nodes.append(Node(Coordinates(7,5)))
        nodes.append(Node(Coordinates(7,4)))
        nodes.append(Node(Coordinates(7,3)))
        nodes.append(Node(Coordinates(6,3)))
        nodes.append(Node(Coordinates(5,3))) //5
        nodes.append(Node(Coordinates(5,4)))
        nodes.append(Node(Coordinates(5,5)))
        nodes.append(Node(Coordinates(4,5)))
        nodes.append(Node(Coordinates(3,5)))
        
        for index in 1 ..< nodes.count {
            nodes[index-1].addConnectedNodeWithBackLink(nodes[index])
        }
        
        XCTAssertEqual(nodes[0].position, toNormalPoint(nodes[0], -RoadType.DeadEnd.offset, 0), "")
        XCTAssertEqual(nodes[1].position, toNormalPoint(nodes[1], +RoadType.Turn.offset, -RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[2].position, toNormalPoint(nodes[2], 0, 0), "")
        XCTAssertEqual(nodes[3].position, toNormalPoint(nodes[3], -RoadType.Turn.offset, RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[4].position, toNormalPoint(nodes[4], 0, 0), "")
        XCTAssertEqual(nodes[5].position, toNormalPoint(nodes[5], +RoadType.Turn.offset, RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[6].position, toNormalPoint(nodes[6], 0, 0), "")
        XCTAssertEqual(nodes[7].position, toNormalPoint(nodes[7], -RoadType.Turn.offset, -RoadType.Turn.offset), "")
        XCTAssertEqual(nodes[8].position, toNormalPoint(nodes[8], 0,0), "")
        XCTAssertEqual(nodes[9].position, toNormalPoint(nodes[9], RoadType.DeadEnd.offset, 0), "")
    }
    
    func testRoadTilePosition3() {
        nodes.append(Node(Coordinates(5,5)))
        nodes.append(Node(Coordinates(5,6)))
        nodes.append(Node(Coordinates(5,7)))
        nodes.append(Node(Coordinates(4,6)))
        
        nodes[0].addConnectedNodeWithBackLink(nodes[1])
        nodes[1].addConnectedNodeWithBackLink(nodes[2])
        nodes[1].addConnectedNodeWithBackLink(nodes[3])
        
        
        XCTAssertEqual(nodes[0].position, toNormalPoint(nodes[0], 0, RoadType.DeadEnd.offset), "")
        XCTAssertEqual(nodes[1].position, toNormalPoint(nodes[1], -RoadType.TJunction.offset, 0), "")
        XCTAssertEqual(nodes[2].position, toNormalPoint(nodes[2], 0, -RoadType.DeadEnd.offset), "")
        XCTAssertEqual(nodes[3].position, toNormalPoint(nodes[3], RoadType.DeadEnd.offset, 0), "")
    }
    
    private func toNormalPoint(node: Node, _ x: CGFloat, _ y: CGFloat) -> CGPoint {
        return CGPointMake(
            CGFloat(node.coordinates.x) * GameMapConfig.Grid.width + GameMapConfig.Grid.width/2 + GameMapConfig.MapXOffset + x,
            CGFloat(node.coordinates.y) * GameMapConfig.Grid.height + GameMapConfig.Grid.height/2 + GameMapConfig.MapYOffset + y)
    }

}
