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
    
    let sourceInput: Input
    let validator: FieldTextInputValidator
    
    init(_ sourceInput: Input, returnType: ReturnType) {
        self.sourceInput = sourceInput
        self.validator = returnType.provideValidator()
        super.init(frame: CGRectZero)
        self.addTarget(self, action: "textDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.backgroundColor = FieldTextInputValidColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func textDidChange(sender: UITextField) {
        backgroundColor = validator.validate(text) ? FieldTextInputValidColor : FieldTextInputInvalidColor
        sizeToFit()
        sourceInput.updateFieldPositions()
    }
    
    override public func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        validator.validateAndUpdate(text)
        text = validator.lastValidInput
        sourceInput.sourceBlock.blocklyCore.args[0] = text
        sizeToFit()
        sourceInput.updateFieldPositions()
        backgroundColor = FieldTextInputValidColor
        self.endEditing(true)
    }
    
    required public init(coder aDecoder: NSCoder) {
        validator = FieldTextInputNoValidator()
        fatalError("init(coder:) has not been implemented")
    }
    
}