//
//  ConnectionTests.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class ConnectionTests: XCTestCase {
    
    let factory = BlocklyFactory()
    let b1 = BlocklyFactory().createMoveForwardBlock()
    let b2 = BlocklyFactory().createMoveForwardBlock()

    func testConnectionEquality1() {
        let c1 = Connection(b1, .PreviousConnection, CGPointZero)
        let c2 = Connection(b1, .PreviousConnection, CGPointZero)
        XCTAssertTrue(c1 == c2, "")
    }

    func testConnectionEquality2() {
        let b1 = factory.createMoveForwardBlock()
        let c1 = Connection(b1, .PreviousConnection, CGPointZero)
        let c2 = Connection(b1, .NextConnection, CGPointZero)
        XCTAssertFalse(c1 == c2, "")
    }
    
    func testConnectionEquality3() {
        let b1 = factory.createMoveForwardBlock()
        let b2 = factory.createMoveForwardBlock()
        let c1 = Connection(b1, .PreviousConnection, CGPointZero)
        let c2 = Connection(b2, .PreviousConnection, CGPointZero)
        XCTAssertFalse(c1 == c2, "")
    }
    
    func testConnectionEquality4() {
        let b1 = factory.createMoveForwardBlock()
        var c1: Connection?
        let c2 = Connection(b1, .PreviousConnection, CGPointZero)
        XCTAssertFalse(c1 == nil, "")
    }
    
    func testConnectionEquality5() {
        let b1 = factory.createMoveForwardBlock()
        let c1 = Connection(b1, .PreviousConnection, CGPointZero)
        var c2 : Connection?
        XCTAssertFalse(c1 == c2, "")
    }
    

}
