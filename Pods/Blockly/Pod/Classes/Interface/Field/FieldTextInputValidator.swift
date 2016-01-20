//
//  FieldTextInputValidator.swift
//  Blockly
//
//  Created by Joey Chan on 12/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public protocol FieldTextInputValidator {
    var lastValidInput: String {get set}
    func validate(string: String) -> Bool
    func validateAndUpdate(string: String) -> Bool
}

public class FieldTextInputIntegerValidator: FieldTextInputValidator {
    
    public var lastValidInput: String = "0"
    
    public func validate(string: String) -> Bool {
        return Int(string) != nil
    }
    
    public func validateAndUpdate(string: String) -> Bool {
        if let result = Int(string) {
            lastValidInput = String(result)
        }
        return validate(string)
    }
}

public class FieldTextInputNoValidator: FieldTextInputValidator {
    public var lastValidInput: String = ""
    public func validate(string: String) -> Bool {
        return true
    }
    
    public func validateAndUpdate(string: String) -> Bool {
        lastValidInput = string
        return true
    }
}

