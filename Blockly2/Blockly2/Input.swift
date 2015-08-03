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
    case Statment
    case Dummy
}

class Input: UIView {
    
    let defaultColor = UIColor.clearColor()
    let defaultFrame = CGRect(origin: CGPointZero, size: CGSizeMake(120, 60))
    
    lazy var textLabel =  UILabel()
    var field: String = "" {
        didSet { updateTextLabel() }
    }
    
    unowned var sourceBlock: Blockly
    
    /**
     Initialization
     @param type Input type of the input
     @field String to display on the input
     */
    init(sourceBlock: Blockly, type: InputType, field: String) {
        self.field = field
        self.sourceBlock = sourceBlock
        super.init(frame: defaultFrame)
        backgroundColor = defaultColor
        addSubview(textLabel)
        updateTextLabel()
    }

    required init(coder aDecoder: NSCoder) {
        self.field = ""
        self.sourceBlock = Blockly(buildClosure: {
            $0.center = CGPointZero
        })
        super.init(coder: aDecoder)
    }
    
    /**
     Update the UILabel to display the @field text
     @param field String to display
     */
    private func updateTextLabel() {
        /** Update Text */
        textLabel.text = field
        
        /** Resize textLabel to fit Input View height and text width */
        textLabel.frame = self.bounds
        let frameHeight = textLabel.frame.height
        textLabel.sizeToFit()
        textLabel.frame.size.height = frameHeight
        
        /** Resize Input View to just include all the subviews */
        self.frame.size.width = subviews.reduce(0, combine: {max($0, $1.frame.size.width)})
        
        /**
         Update Blockly View to just include all the Input views
         Must be larger then the minimalSize
         */
        sourceBlock.frame.size.width = max(sourceBlock.frame.width, self.frame.width + 20)
        /**
         Update all the Input views to fit the Blockly View
         */
        sourceBlock.updateInputsFrame()
    }
    
}
