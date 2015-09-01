//
//  ReturnType.swift
//  Blockly
//
//  Created by Joey Chan on 12/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public enum ReturnType {
    
    case Integer
    case Boolean
    
    func provideValidator() -> FieldTextInputValidator {
        switch self {
            case .Integer:
                return FieldTextInputIntegerValidator()
                
            default:
                return FieldTextInputNoValidator()
        }
    }
}