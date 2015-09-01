//
//  Input.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class Input: UIView {
    
    unowned var sourceBlock: Blockly
    public var connectionPoint: InputConnectionPoint?
    
    var type: InputType
    
    public var fields = [UIView]() {
        didSet {
            displayFields()
        }
    }
    
    var targetBlockly: Blockly? {
        return connectionPoint?.connection.targetConnection?.sourceBlock.blockly
    }
    
    var totalHeight: CGFloat {
        if let inputConnection = connectionPoint?.connection as? InputConnection {
            switch inputConnection.inputType {
            case .Value:
                if let targetBlockly = connectionPoint?.connection.targetConnection?.sourceBlock.blockly {
                    return targetBlockly.totalHeight - TabSize.height - BlankSize.height
                }
            case .Statement:
                if let targetBlockly = connectionPoint?.connection.targetConnection?.sourceBlock.blockly {
                    return targetBlockly.totalHeight + ShelfHeight
                }
                return DefaultBlocklySize.height + TabSize.height + BlankSize.height + ShelfHeight
            default: break
            }
        }
        return DefaultInputFrame.height
    }
    
    public init(sourceBlock: Blockly, type: InputType) {
        self.type = type
        self.sourceBlock = sourceBlock
        super.init(frame: DefaultInputFrame)
        self.backgroundColor = DefaultInputBackgroundColor
        setupConnection()
        if let lastInput = sourceBlock.inputs.last {
            frame.origin = lastInput.frame.origin + CGPointMake(0, lastInput.frame.height)
        }
        sourceBlock.inputs.append(self)
    }
    
    public func displayFields() {
        subviews.foreach({$0.removeFromSuperview()})
        fields.foreach({[unowned self] in self.addSubview($0)})
        updateFieldPositions()
    }
    
    public func updateFieldPositions() {
        for (index, field) in enumerate(fields) {
            if index < 1 {
                field.frame.origin = CGPointZero
            } else {
                let previousFrame = fields[index-1].frame
                field.frame.origin = CGPointMake(previousFrame.origin.x + previousFrame.width + 10, previousFrame.origin.y)
            }
            field.sizeToFit()
        }
        sizeToFit()
    }
    
    public func appendField(name: String) -> Input {
        let field = UILabel()
        field.text = name
        fields.append(field)
        return self
    }
    
    public func appendFieldTextInput(type: ReturnType) -> Input {
        let field = FieldTextInput(self, returnType: type)
        if let lastField = fields.last {
            field.frame.origin = CGPointMake(lastField.frame.origin.x + lastField.frame.width + 10, lastField.frame.origin.y)
        }
        self.fields.append(field)
        self.sourceBlock.blocklyCore.args.append("")
        return self
    }
    
    public func setCheck(returnType: ReturnType) {
        if let connection = self.connectionPoint?.connection as? InputValueConnection {
            connection.returnType = returnType
        }
    }
    
    private func setupConnection() {
        switch type {
            case .Value:
                self.connectionPoint = InputValueConnectionPoint(self)
            case .Statement:
                self.connectionPoint = InputStatementConnectionPoint(self)
            default: break
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.sourceBlock = Blockly(buildClosure: {$0.center = CGPointZero})
        self.type = .Dummy
        super.init(coder: aDecoder)
    }
    
}
