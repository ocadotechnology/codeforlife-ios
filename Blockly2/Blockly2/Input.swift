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
    
    init(type: InputType, field: String) {
        super.init(frame: defaultFrame)
        backgroundColor = defaultColor
        setupTextLabel(field)
    }

    required init(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    /**
     Setup the UILabel to display the @field text
     @param field String to display
     */
    private func setupTextLabel(field: String) {
        textLabel.text = field
        textLabel.frame = self.bounds
        let frameHeight = textLabel.frame.height
        textLabel.sizeToFit()
        textLabel.frame.size.height = frameHeight
        addSubview(textLabel)
        self.frame.size.width = max(defaultFrame.size.width, subviews.reduce(0, combine: {max($0, $1.frame.size.width)}) + 20)
    }
    
}
