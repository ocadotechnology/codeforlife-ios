//
//  Input.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

enum InputType {
    case Value
    case Statment
    case Dummy
}

class Input: UIView {
    
    let defaultColor = UIColor(red: 64/255, green: 208/255, blue: 192/255, alpha: 1) //#40D0C0
    let defaultFrame = CGRect(origin: CGPointZero, size: CGSizeMake(80, 40))
    
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
        textLabel.text = field
        textLabel.frame = self.bounds
        let frameHeight = textLabel.frame.height
        textLabel.sizeToFit()
        textLabel.frame.size.height = frameHeight
        self.frame.size.width = subviews.reduce(0, combine: {max($0, $1.frame.size.width)})
        sourceBlock.frame.size.width = max(sourceBlock.frame.width, self.frame.width)
        sourceBlock.updateInputsFrame()
    }
    
}
