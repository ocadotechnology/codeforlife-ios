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
    let defaultColor = UIColor(red: 64/255, green: 208/255, blue: 192/255, alpha: 1) //#40D0C0
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
     Contact Point to establish connection with another block
     */
    var nextConnection: Connection?
    
    /**
     Contact Point to establish connection with another block
     */
    var previousConnection: Connection?
    
    /**
     Center of the blockly
     @didSet update next blockly position
     */
    override public var center: CGPoint {
        didSet {
            nextConnection?.position = center + CGPointMake(0, frame.height/2)
            previousConnection?.position = center  + CGPointMake(0, -frame.height/2)
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
        nextConnection?.targetConnection?.sourceBlock.snapToNeighbour()
    }
    
    /**
     This blockly is allowed to have a next statement by default
     */
    var allowNextStatement = true {
        didSet {
            println(self.nextConnection)
            println(initializeNextConnection)
            self.nextConnection = allowNextStatement ? initializeNextConnection() : nil
            println(self.nextConnection)
        }
    }
    
    private func initializeNextConnection() -> Connection {
        let type = ConnectionType.NextConnection
        let position = center + CGPointMake(0, frame.height/2)
        let connection = Connection(self, type, position)
        return connection
    }
    
    /**
     this blockly is allowed to have a previous statement by default
     */
    var allowPreviousStatement = true {
        didSet {
            self.previousConnection = allowPreviousStatement ? initializePreviousConnection() : nil
        }
    }
    
    private func initializePreviousConnection() -> Connection {
        let type = ConnectionType.PreviousConnection
        let position = center + CGPointMake(0, -frame.height/2)
        let connection = Connection(self, type, position)
        return connection
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
        self.nextConnection = initializeNextConnection()
        self.previousConnection = initializePreviousConnection()
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
        let includeConnected = true
        
        /** Search for the current closest connections */
        let nextBlockly = nextConnection?.findClosestConnection(searchRadius, includeConnected)?.sourceBlock
        let previousBlockly = previousConnection?.findClosestConnection(searchRadius, includeConnected)?.sourceBlock
        
        /** Disconnect all connections */
        self.connectNextBlockly(nil)
        self.connectPreviousBlockly(nil)
        
        /** Reconnection all the connections */
        self.connectNextBlockly(nextBlockly)
        self.connectPreviousBlockly(previousBlockly)
    }
    
    func findClosestBlockly() -> Blockly? {
        var result: Blockly?
        let includeConnected = true
        if let blockly = nextConnection?.findClosestConnection(searchRadius, includeConnected)?.sourceBlock {
            result = blockly
        } else if let blockly = previousConnection?.findClosestConnection(searchRadius, includeConnected)?.sourceBlock {
            result = blockly
        }
        return result
    }
    
    /**
     Update Next Blockly 
     @param otherBlockly reference to the new blockly or nil to disconnect from the next blockly
     */
    public func connectNextBlockly(otherBlockly: Blockly?) {
        if self.nextConnection?.targetConnection?.sourceBlock == otherBlockly {
            otherBlockly?.snapToNeighbour()
        } else if otherBlockly?.previousConnection?.targetConnection != nil {
            /** Already have a next blockly */
            
            /** Detach the original next blockly */
            
            /** Attach the new next blockly */
            
            /** Reattach the original next blockly after the new next blockly */
            
        } else {
            /** Attach to the next blockly */
            self.nextConnection?.targetConnection?.targetConnection = nil
            self.nextConnection?.targetConnection = otherBlockly?.previousConnection
            otherBlockly?.previousConnection?.targetConnection = self.nextConnection
            otherBlockly?.snapToNeighbour()
        }
    }
    
    
    /**
     Update PreviousBlockly
     @param, otherBlockly reference to the new blockly or nil to disconnect from the previous blockly
     */
    public func connectPreviousBlockly(otherBlockly: Blockly?) {
        if self.previousConnection?.targetConnection?.sourceBlock == otherBlockly {
            otherBlockly?.snapToNeighbour()
        } else if otherBlockly?.nextConnection?.targetConnection != nil {
            /** otherBlockly Already have a previous blockly */
        } else {
            /** Attach to the previous blockly */
            self.previousConnection?.targetConnection?.targetConnection = nil
            self.previousConnection?.targetConnection = otherBlockly?.nextConnection
            otherBlockly?.nextConnection?.targetConnection = self.previousConnection
            snapToNeighbour()
        }
    }
    
    func snapToNeighbour() {
        let previousBlockly = previousConnection?.targetConnection?.sourceBlock
        let newPosition = previousBlockly?.nextConnection?.position
        if let newPosition = newPosition {
            self.previousConnection?.position = newPosition
            self.previousConnection?.updateSourceBlockCenter()
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
        allowNextStatement = true
        allowPreviousStatement = true
        super.init(coder: aDecoder)
    }

}
