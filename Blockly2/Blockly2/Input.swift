//
//  Input.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

enum InputType {
    case Value
    case Statement
    case Dummy
}

class Input: UIView {
    
    let defaultColor = UIColor.clearColor()
    let defaultFrame = CGRect(origin: CGPointZero, size: CGSizeMake(150, 40))
    let defaultBorderWidth: CGFloat = 1
    let defaultBorderColor = UIColor.grayColor().CGColor
    
    lazy var textLabel =  UILabel()
    
    var field: String {
        didSet { updateTextLabel() }
    }
    
    var connection: InputConnection?
    
    var type: InputType
    
    unowned var sourceBlock: Blockly
    
    var totalHeight: CGFloat {
        return connection?.totalHeight ?? defaultFrame.height
    }
    
    /**
        Initialization

        :param: type Input type of the input
     
        :param: field String to display on the input
     */
    init(sourceBlock: Blockly, type: InputType, field: String) {
        self.field = field
        self.type = type
        self.sourceBlock = sourceBlock
        super.init(frame: defaultFrame)
        self.backgroundColor = defaultColor
        self.layer.borderWidth = defaultBorderWidth
        self.layer.borderColor = defaultBorderColor
        addSubview(textLabel)
        updateTextLabel()
        setupConnection()
    }

    required init(coder aDecoder: NSCoder) {
        self.field = ""
        self.sourceBlock = Blockly(buildClosure: { $0.center = CGPointZero })
        self.type = .Dummy
        super.init(coder: aDecoder)
    }
    
    /**
        Update the UILabel to display the @field text
     
        :param: field String to display
     */
    private func updateTextLabel() {
        /** Update Text */
        textLabel.text = field
        
        /** Resize textLabel to fit Input View height and text width */
        textLabel.frame = self.bounds
    }
    
    func setupConnection() {
        switch type {
            case .Value:        self.connection = InputValueConnection(self)
            case .Statement:    self.connection = InputStatementConnection(self)
            default: break
        }
    }
    
}
