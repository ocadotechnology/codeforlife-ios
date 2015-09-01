//
//  Connection.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

typealias ConnectionResult = (Connection, CGFloat)

public protocol Connection: class {
    
    var type: ConnectionType {get}
    unowned var sourceBlock: BlocklyCore {get}
    weak var targetConnection: Connection? {get set}
    
    func connect(otherConnection: Connection?)
    func matchSearchCondition(otherConnection: Connection) -> Bool
    
}

func ==(lhs: Connection, rhs: Connection) -> Bool {
    return lhs.type == rhs.type && lhs.sourceBlock.blockly == rhs.sourceBlock.blockly
}
