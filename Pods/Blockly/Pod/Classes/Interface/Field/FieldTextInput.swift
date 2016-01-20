//
//  Field.swift
//  Blockly
//
//  Created by Joey Chan on 11/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class FieldTextInput: UITextField {
    
    let FieldTextInputValidColor = UIColor.whiteColor()
    let FieldTextInputInvalidColor = UIColor.redColor()
    
    let index: Int
    let sourceInput: Input
    let validator: FieldTextInputValidator
    
    init(_ sourceInput: Input, returnType: Int, index: Int) {
        self.index = index
        self.sourceInput = sourceInput
        self.validator = ReturnType.provideValidator(returnType)
        super.init(frame: CGRectZero)
        self.addTarget(self, action: "textDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.addTarget(self, action: "textDidEnd:", forControlEvents: UIControlEvents.EditingDidEnd)
        self.backgroundColor = FieldTextInputValidColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func textDidChange(sender: UITextField) {
        if let text = text {
            backgroundColor = validator.validate(text) ? FieldTextInputValidColor : FieldTextInputInvalidColor
            sourceInput.updateFieldPositions()
        }
    }
    
    func textDidEnd(sender: UITextField) {
        if let text = text {
            validator.validateAndUpdate(text)
            self.text = validator.lastValidInput
            sourceInput.sourceBlocklyView.blockly.args[index] = text
            sourceInput.updateFieldPositions()
        }
        backgroundColor = FieldTextInputValidColor
        self.endEditing(true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        validator = FieldTextInputNoValidator()
        fatalError("init(coder:) has not been implemented")
    }
    
}