//
//  ConnectionType.swift
//  Blockly
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public enum ConnectionType: String {
    
    case InputValue = "InputValue"
    case OutputValue = "OutputValue"
    case NextStatement = "NextStatement"
    case PreviousStatement = "PreviousStatement"
    
    var oppositeType: ConnectionType {
        switch self {
        case .InputValue: return .OutputValue
        case .OutputValue: return .InputValue
        case .NextStatement: return .PreviousStatement
        case .PreviousStatement: return .NextStatement
        }
    }
}