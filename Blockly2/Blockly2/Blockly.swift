//
//  Blockly.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class Blockly: UIView {

    let defaultSize = CGSizeMake(120, 60)
    let defaultCenter = CGPointMake(400, 400)
    let defaultColor = UIColor.blueColor()
    let searchRadius:CGFloat = 20
    
    /**
     Minimal Size of the Blockly, which the blockly should never be small than this size
     */
    var minimalSize: CGSize
    
    /**
     List of all the inputs
     Upon changes, the blockly view will be reset
     */
    var inputs = [Input]() {
        didSet {
            render()
        }
    }
    
    /**
     Return a reference to the next blockly, nil if there does not exists one
     */
    weak var nextBlockly: Blockly?
    
    /**
     Return a reference to the previous blockly, nil if there does not exists one
     Only add observer in either nextBlockly or previousBlockly to avoid infinite recursion
     @willSet remove reference from previous blockly
     @didSet setup reference to the new previous blockly
     */
    weak var previousBlockly: Blockly? {
        willSet { self.previousBlockly?.nextBlockly = nil }
        didSet { self.previousBlockly?.nextBlockly = self }
    }
    
    /**
     Contact Point to establish connection with another block
     @get CGPoint in the middle of the top frame, nil if blockly does not allow a next blockly
     @set If new value is not nil, blockly center will be updated to fit the contact point
     */
    var nextConnection: Connection? {
        get {
            let type = ConnectionType.NextConnection
            let position = center + CGPointMake(0, frame.height/2)
            let connection = Connection(self, type, position)
            return allowNextStatement ? connection : nil
        }
    }
    
    /**
     Contact Point to establish connection with another block
     @get CGPoint in the middle of the bottom frame, nil if blockly does not allow a previous blockly
     @set If new value is not nil, blockly center will be updated to fit the contact point
     */
    var previousConnection: Connection? {
        get {
            let type = ConnectionType.PreviousConnection
            let position = center + CGPointMake(0, -frame.height/2)
            let connection = Connection(self, type, position)
            return allowPreviousStatement ? connection : nil
        }
        set {
            if let previousConnection = newValue?.position {
                center = previousConnection + CGPointMake(0, frame.height/2)
            }
        }
    }
    
    /**
     Center of the blockly
     @didSet update next blockly position
     */
    override public var center: CGPoint {
        didSet {
            updateNextPosition()
        }
    }
    
    /**
     Return a list of all the connections this blockly consists of
     */
    var connections: [Connection] {
        var connections = [Connection]()
        if nextConnection != nil {
            connections.append(nextConnection!)
        }
        if previousConnection != nil {
            connections.append(previousConnection!)
        }
        return connections
    }
    
    /**
     Update next blockly's previous contact point to stick to my next contact point
     */
    func updateNextPosition() {
        nextBlockly?.snapToNeighbour()
    }
    
    /**
     This blockly is allowed to have a next statement by default
     */
    var allowNextStatement = true
    
    /**
     this blockly is allowed to have a previous statement by default
     */
    var allowPreviousStatement = true
    
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
    
    /**
     Update the view of the blockly
     */
    func render() {
        
        /** Calculate and update the height of the blockly */
        let newHeight = max(minimalSize.height, CGFloat(inputs.count)*defaultSize.height)
        let oldOrigin = frame.origin
        frame.size.height = newHeight
        frame.origin = oldOrigin
        
        /** Remove all the Inputs and redisplay them */
        self.removeAllSubviews()
        for input in inputs {
            addSubview(input)
        }
        updateInputsFrame()
    }
    
    /**
     Reposition all the subviews and resize their widths to follow the blockly frame width
     */
    func updateInputsFrame() {
        for (index, input) in enumerate(inputs) {
            /** Adjust position */
            input.frame.origin = CGPointMake(0, CGFloat(index)*defaultSize.height)
            /** Adjust width */
            input.frame.size.width = self.frame.width
        }
    }
    
    /**
     Removed all subviews
     */
    private func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    /**
     Locate the cloest contact point for each valid contact point of this blockly
     */
    func updateNeighbour() {
        let nextBlockly = nextConnection?.findClosestConnection(searchRadius)?.sourceBlock
        self.connectNextBlockly(nextBlockly)
        
        let previousBlockly = previousConnection?.findClosestConnection(searchRadius)?.sourceBlock
        self.connectPreviousBlockly(previousBlockly)
    }
    
    func findClosestBlockly() -> Blockly? {
        if let blockly = nextConnection?.findClosestConnection(searchRadius)?.sourceBlock {
            return blockly
        } else if let blockly = previousConnection?.findClosestConnection(searchRadius)?.sourceBlock {
            return blockly
        }
        return nil
    }
    
    /**
     Update Next Blockly 
     @param otherBlockly reference to the new blockly or nil to disconnect from the next blockly
     */
    public func connectNextBlockly(otherBlockly: Blockly?) {
        if otherBlockly?.previousBlockly != nil {
            /** Already have a next blockly */
            
            /** Detach the original next blockly */
            
            /** Attach the new next blockly */
            
            /** Reattach the original next blockly after the new next blockly */
            
        } else {
            /** Attach to the next blockly */
            otherBlockly?.previousBlockly = self
            otherBlockly?.snapToNeighbour()
        }
    }
    
    
    /**
     Update PreviousBlockly
     @param, otherBlockly reference to the new blockly or nil to disconnect from the previous blockly
     */
    public func connectPreviousBlockly(otherBlockly: Blockly?) {
        if otherBlockly?.nextBlockly != nil {
            /** otherBlockly Already have a previous blockly */
        } else {
            /** Attach to the previous blockly */
            previousBlockly = otherBlockly
            snapToNeighbour()
        }
    }
    
    func snapToNeighbour() {
        if let blockly = previousBlockly {
            self.previousConnection = blockly.nextConnection
        }
        updateNextPosition()
    }
    
    /**
     Add a new Input to the blockly
     @param type Input type of the input
     @param field String to be displayed
     */
    func appendInput(type: InputType, field: String) {
        inputs.append(Input(sourceBlock: self, type: type, field: field))
    }
    
    /**
     Remove Input at @index
     @param index: index of input to be removed
     */
    public func removeInput(index: Int) {
        inputs.removeAtIndex(index)
    }
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    required public init(coder aDecoder: NSCoder) {
        minimalSize = defaultSize
        super.init(coder: aDecoder)
    }

}
