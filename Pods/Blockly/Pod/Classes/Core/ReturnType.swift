//
//  ReturnType.swift
//  Blockly
//
//  Created by Joey Chan on 12/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class ReturnType {
    
    public static let None     = 0b00000000
    public static let Integer  = 0b00000001
    public static let Boolean  = 0b00000010
    public static let String   = 0b00000100
    public static let Variable = 0b00001000
    public static let All      = 0b11111111
    
    static func provideValidator(returnType: Int) -> FieldTextInputValidator {
        switch returnType {
            case ReturnType.Integer:
                return FieldTextInputIntegerValidator()
                
            default:
                return FieldTextInputNoValidator()
        }
    }
}