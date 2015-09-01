//
//  InputConnection.swift
//  Blockly
//
//  Created by Joey Chan on 04/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class InputConnection: Connection {
    
    public unowned let sourceBlock: BlocklyCore
    public weak var targetConnection: Connection?
    public let type: ConnectionType
    public var inputType: InputType
    
    init(_ sourceBlock: BlocklyCore, _ inputType: InputType) {
        self.inputType = inputType
        self.sourceBlock = sourceBlock
        self.type = .InputValue
    }

    public func connect(otherConnection: Connection?) {}
    public func matchSearchCondition(otherConnection: Connection) -> Bool { return false }

}