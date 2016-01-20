//
//  InputCustomisation.swift
//  Pods
//
//  Created by Joey Chan on 14/09/2015.
//
//

import Foundation

public extension Input {
    
    public func appendField(str: String) -> Input {
        let field = UILabel()
        field.text = str
        fields.append(field)
        self.addSubview(field)
        return self
    }
    
    public func appendFieldTextInput(type: Int) -> Input {
        self.sourceBlocklyView.blockly.args.append("")
        let field = FieldTextInput(self, returnType: type, index: sourceBlocklyView.blockly.args.count-1)
        if let lastField = fields.last {
            field.frame.origin = CGPointMake(lastField.frame.origin.x + lastField.frame.width + 10, lastField.frame.origin.y)
        }
        self.fields.append(field)
        self.addSubview(field)
        return self
    }
    
    public func appendFieldDropDown(data: [String]) -> Input {
        let field = FieldDropDown(data: data)
        fields.append(field)
        self.addSubview(field)
        return self
    }
    
    public func setCheck(returnType: Int) {
        (self.connectionPoint?.connection as? InputValueConnection)?.returnType = returnType
    }
    
}
