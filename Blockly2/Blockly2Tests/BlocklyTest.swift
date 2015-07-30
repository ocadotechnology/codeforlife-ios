//
//  BlocklyTest.swift
//  Blockly2
//
//  Created by Joey Chan on 03/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import XCTest

class BlocklyTest: XCTestCase {
    
    let factory = BlocklyFactory()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBlocklyInit1() {
        let blockly = factory.createMoveForwardBlock()
        XCTAssertNotNil(blockly.nextConnection, "Next Connection is nil")
        XCTAssertNotNil(blockly.previousConnection, "Previous Connection is nil")
    }
    
    func testIfThenBlocklyInit() {
        let blockly = factory.createIfThenBlock()
        let input1 = blockly.inputs.first
        let input2 = blockly.inputs.last
        XCTAssertNotNil(blockly.nextConnection, "Next connection is nil")
        XCTAssertNotNil(blockly.previousConnection, "Previous connection is nil")
        XCTAssertNotNil(input1, "If Input is nil")
        XCTAssertNotNil(input2, "Then Input is nil")
        XCTAssertNotNil(input1?.connection, "If Input Connection is nil")
        XCTAssertNotNil(input2?.connection, "Then Input Connection is nil")
        XCTAssertTrue(input1?.connection?.type == ConnectionType.InputValue, "Input1 Conenction Type is not correct")
        XCTAssertTrue(input2?.connection?.type == ConnectionType.InputValue, "Input2 Conenction Type is not correct")
        XCTAssertNil(blockly.outputConnection, "Outputconnection is not nil")
        XCTAssertEqual(blockly.connections.count, 4, "Connection Count is not correct")
    }
    
    func testTrueBlockInit() {
        let blockly = factory.createTrueBlock()
        XCTAssertNil(blockly.nextConnection, "Next connection is not nil")
        XCTAssertNotNil(blockly.outputConnection, "Output conenction shoult not be nil")
        XCTAssertTrue(blockly.outputConnection?.type == ConnectionType.OutputValue, "Output Connection Type is not correct")
    }
    
    func testAllowNextStatement() {
        let blockly = factory.createMoveForwardBlock()
        XCTAssertNotNil(blockly.nextConnection, "Next connection is nil")
        blockly.allowNextStatement = false
        XCTAssertNil(blockly.nextConnection, "Next connection should be nil")
        blockly.allowNextStatement = true
        XCTAssertNotNil(blockly.nextConnection, "Next connection should be not nil again")
    }
    
    func testAllowPreviousStatement() {
        let blockly = factory.createMoveForwardBlock()
        XCTAssertNotNil(blockly.previousConnection, "Next connection is nil")
        blockly.allowPreviousStatement = false
        XCTAssertNil(blockly.previousConnection, "Next connection should be nil")
        blockly.allowPreviousStatement = true
        XCTAssertNotNil(blockly.previousConnection, "Next connection should be not nil again")
    }
    
    func testLastBlockly1() {
        let blockly = factory.createMoveForwardBlock()
        XCTAssertEqual(blockly, blockly.lastBlockly, "lastBlockly should be itself")
    }
    
    func testLastBlockly2() {
        let blockly1 = factory.createMoveForwardBlock()
        let blockly2 = factory.createMoveForwardBlock()
        blockly1.connectNextBlockly(blockly2)
        XCTAssertEqual(blockly2, blockly1.lastBlockly, "blockly2 should be the lastBlockly of blockly")
    }
    
    func testLastBlockly3() {
        let blockly1 = factory.createMoveForwardBlock()
        let blockly2 = factory.createMoveForwardBlock()
        let blockly3 = factory.createMoveForwardBlock()
        blockly1.connectNextBlockly(blockly2)
        blockly1.connectNextBlockly(blockly3)
        XCTAssertEqual(blockly3, blockly1.lastBlockly, "blockly2 should be the lastBlockly of blockly")
    }
    
    func testConnectNextBlockly1() {
        let blockly1 = factory.createMoveForwardBlock()
        let blockly2 = factory.createMoveForwardBlock()
        let blockly3 = factory.createMoveForwardBlock()
        
        XCTAssertNotNil(blockly1.nextConnection, "blockly1.nextConnection should not be nil")
        XCTAssertNotNil(blockly2.previousConnection, "blockly2.nextConnection should not be nil")
        XCTAssertNil(blockly1.nextConnection?.targetConnection, "blockly1.nextConnection.targetConnection should be nil")
        XCTAssertNil(blockly2.previousConnection?.targetConnection, "blockly2.previousConnection.targetConnection should be nil")
        
        blockly1.connectNextBlockly(blockly2)
        XCTAssertNotNil(blockly1.nextConnection?.targetConnection, "blockly1.nextConnection.targetConnection should not be nil")
        XCTAssertNotNil(blockly2.previousConnection?.targetConnection, "blockly2.previousConnection.targetConnection should not be nil")
        XCTAssertTrue(blockly1.nextConnection?.targetConnection == blockly2.previousConnection, "")
        XCTAssertTrue(blockly2.previousConnection?.targetConnection == blockly1.nextConnection, "")
        
        blockly1.connectNextBlockly(blockly3)
        XCTAssertNil(blockly2.previousConnection?.targetConnection, "blockly2.previousConnection.targetConnection should be nil")
        XCTAssertNotNil(blockly1.nextConnection?.targetConnection, "blockly1.nextConnection.targetConnection should not be nil")
        XCTAssertNotNil(blockly3.previousConnection?.targetConnection, "blockly3.previousConnection.targetConnection should not be nil")
        
    }
    
    


}
