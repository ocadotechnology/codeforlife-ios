//
//  Blockly.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class Blockly: UIView {

    let defaultSize = CGSizeMake(80, 40)
    let defaultCenter = CGPointMake(400, 400)
    let defaultColor = UIColor.blueColor()
    
    var minimalSize: CGSize
    
    var inputs = [Input]() {
        didSet { render() }
    }
    
    /**
    Create a Blockly when customized setting
    @param buildClosure a closure the capture all the customized setting of the newly created blockly
    @return blockly created with them customization
    */
    public init(buildClosure: (Blockly) -> Void) {
        minimalSize = defaultSize
        super.init(frame: CGRect(origin: CGPointZero, size: CGSizeZero))
        frame.size = defaultSize
        backgroundColor = defaultColor
        center = defaultCenter
        buildClosure(self)
    }

    required public init(coder aDecoder: NSCoder) {
        minimalSize = defaultSize
        super.init(coder: aDecoder)
    }
    
    func render() {
        let newHeight = max(minimalSize.height, CGFloat(inputs.count)*defaultSize.height)
        let oldOrigin = frame.origin
        frame.size.height = newHeight
        frame.origin = oldOrigin
        
        /** Remove all the Inputs and redisplay them */
        self.removeAllSubviews()
        for (index, input) in enumerate(inputs) {
            input.frame.origin = self.bounds.origin + CGPointMake(0, CGFloat(index)*defaultSize.height)
            addSubview(input)
        }
        
    }
    
    private func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    func appendInput(type: InputType, field: String) {
        inputs.append(Input(type: type, field: field))
    }
    
    public func removeInput(index: Int) {
        inputs.removeAtIndex(index)
    }
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    

}
