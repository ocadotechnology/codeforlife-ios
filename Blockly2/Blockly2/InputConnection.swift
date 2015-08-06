//
//  InputConnection.swift
//  Blockly2
//
//  Created by Joey Chan on 04/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class InputConnection: Connection {
    
    var sourceInput: Input
    var inputType: InputType
    var totalHeight: CGFloat {
        fatalError("Abstract InputConnection Height")
    }
    
    override var position: CGPoint {
        get { fatalError("Accessing abstract variable"); return CGPointZero }
        set {}
    }
    
    init(_ sourceInput: Input, _ inputType: InputType) {
        self.sourceInput = sourceInput
        self.inputType = inputType
        super.init(sourceInput.sourceBlock, .InputValue, CGPointZero)
    }
    
    func updateTargetConnectionPosition() {
        targetConnection?.position = position
        targetConnection?.updateSourceBlockCenter()
    }
    
}

public class InputConnectionDelegate: ConnectionDelegate {
    
    unowned var connection: InputConnection
    
    init(_ connection: InputConnection) {
        self.connection = connection
    }
    
    func connect(otherConnection: Connection?) {
        println("InputConnections do not initiate connections")
    }
    
    func matchSearchCondition(otherConnection: Connection) -> Bool {
        println("InputConnections do not initiate connections")
        return false
    }
    
    func updateSourceBlockCenter() {
        println("InputConnections do no alter the center of source blockly")
    }
}