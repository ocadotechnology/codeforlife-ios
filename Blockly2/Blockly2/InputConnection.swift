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
    
    override var position: CGPoint {
        get {
            let offset = CGPointMake(sourceInput.frame.width, sourceInput.frame.height/2)
            return sourceInput.sourceBlock.frame.origin + sourceInput.frame.origin + offset
        }
        set {}
    }
    
    init(_ sourceInput: Input, _ inputType: InputType) {
        self.sourceInput = sourceInput
        self.inputType = inputType
        super.init(sourceInput.sourceBlock, .InputValue, CGPointZero)
        self.delegate = InputConnectionDelegate(self)
    }
    
}

public class InputConnectionDelegate: ConnectionDelegate {
    
    unowned var connection: InputConnection
    
    init(_ connection: InputConnection) {
        self.connection = connection
    }
    
    func connect(otherConnection: Connection?) {
        // TODO
    }
    
    func matchSearchCondition(otherConnection: Connection) -> Bool {
        return
        /* 1 */ connection.sourceBlock != otherConnection.sourceBlock &&
        /* 2 */ connection.type == otherConnection.type.oppositeType &&
        /* 3 */ connection.distanceTo(otherConnection) <= connection.searchRadius
    }
    
    func updateSourceBlockCenter() {
        connection.sourceBlock.center = connection.position + connection.positionOffset
    }
}