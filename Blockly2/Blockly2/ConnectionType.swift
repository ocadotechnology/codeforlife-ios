//
//  ConnectionType.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

enum ConnectionType: String {
    case InputValue = "InputValue"
    case OutputValue = "OutputValue"
    case NextConnection = "NextConnection"
    case PreviousConnection = "PreviousConnction"
    
    var oppositeType: ConnectionType {
        switch self {
        case .InputValue: return .OutputValue
        case .OutputValue: return .InputValue
        case .NextConnection: return .PreviousConnection
        case .PreviousConnection: return .NextConnection
        }
    }
}