//
//  FieldTextInputValidator.swift
//  Blockly
//
//  Created by Joey Chan on 12/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class FieldTextInputValidator {
    public var lastValidInput: String = ""
    func validate(string: String) -> Bool {
        fatalError("Implement validate(string: String)")
    }
    func validateAndUpdate(string: String) -> Bool {
        fatalError("Implement validateAndUpdate(string: String")
    }
}

public class FieldTextInputIntegerValidator: FieldTextInputValidator {
    
    var lastValidIntegerInput: String = "0"
    override public var lastValidInput: String {
        get {
            return lastValidIntegerInput
        }
        set {
            lastValidIntegerInput = newValue
        }
    }
    
    public override func validate(string: String) -> Bool {
        return string.toInt() != nil
    }
    
    public override func validateAndUpdate(string: String) -> Bool {
        if let result = string.toInt() {
            lastValidInput = String(result)
        }
        return validate(string)
    }
}

public class FieldTextInputNoValidator: FieldTextInputValidator {
    public override func validate(string: String) -> Bool {
        return true
    }
}

