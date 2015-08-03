//
//  Blockly.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class Blockly: UIView {

    let defaultSize = CGSizeMake(150, 40)
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
        
        Upon changes, update next blockly position
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
            self.nextConnection = allowNextStatement ? createNextConnection() : nil
        }
    }
    
    /**
        This blockly is allowed to have a previous statement by default
     */
    var allowPreviousStatement = true {
        didSet {
            self.previousConnection = allowPreviousStatement ? createPreviousConnection() : nil
        }
    }
    
    var lastBlockly: Blockly {
        if nextConnection == nil || nextConnection?.targetConnection == nil {
            return self
        } else {
            return nextConnection!.targetConnection!.sourceBlock.lastBlockly
        }
    }
    
    /**
        Create a Blockly when customized setting
        
        :param: buildClosure a closure the capture all the customized setting of the newly created blockly
        
        :returns: blockly created with them customization
    */
    public init(buildClosure: (Blockly) -> Void) {
        self.minimalSize = defaultSize
        super.init(frame: CGRect(origin: CGPointZero, size: CGSizeZero))
        self.frame.size = defaultSize
        self.backgroundColor = defaultColor
        self.center = defaultCenter
        self.nextConnection = createNextConnection()
        self.previousConnection = createPreviousConnection()
        buildClosure(self)
    }
    
    /**
        Create a Next Connection
     */
    private func createNextConnection() -> Connection {
        let type = ConnectionType.NextConnection
        let position = center + CGPointMake(0, frame.height/2)
        let connection = Connection(self, type, position)
        return connection
    }
    
    /**
        Create a Previous Connection
     */
    private func createPreviousConnection() -> Connection {
        let type = ConnectionType.PreviousConnection
        let position = center + CGPointMake(0, -frame.height/2)
        let connection = Connection(self, type, position)
        return connection
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
        Locate the cloest contact point for each valid contact point of this blockly and update connetions
     */
    func updateNeighbour() {
        if !PreviousBlocklyUpdated() {
            /**
                 Previous Blockly has the priority to be updated first
                 If no changes in previous blockly but changes in next blockly, apply the change in next blockly
             */
            let includeConnected = true
            let newNextBlockly = self.nextConnection?.findClosestConnection(searchRadius, includeConnected)?.sourceBlock
            self.connectNextBlockly(newNextBlockly)
        }
    }
    
    /**
        Update any change in Previous Blockly
        
        :returns: true if previous blockly has changes, false otherwise
     */
    private func PreviousBlocklyUpdated() -> Bool {
        let includeConnected = true
        let oldPreviousBlockly = self.previousConnection?.targetConnection?.sourceBlock
        let newPreviousBlockly = self.previousConnection?.findClosestConnection(searchRadius, includeConnected)?.sourceBlock
        self.connectPreviousBlockly(newPreviousBlockly)
        return oldPreviousBlockly != newPreviousBlockly
    }
    
    
    /**
     Find the connection point which is closest to any connection point of this blockly
     */
    func findClosestConnection() -> Connection? {
        var closest: Connection?
        var shortestDistance: CGFloat = -1
        let includeConnected = true
        if let connection = nextConnection?.findClosestConnection(searchRadius, includeConnected).0 {
            closest = connection
            shortestDistance = distanceBetween(nextConnection!.position, connection.position)
        }
        if let connection = previousConnection?.findClosestConnection(searchRadius, includeConnected) {
            let distance = distanceBetween(previousConnection!.position, connection.position)
            if closest == nil {
                closest = connection
                shortestDistance = distance
            } else if distanceBetween(previousConnection!.position, connection.position) < shortestDistance {
                closest = connection
                shortestDistance = distance
            }
        }
        return closest
    }
    
    /**
        Update Next Blockly
    
        :param: otherBlockly reference to the new blockly or nil to disconnect from the next blockly
     */
    public func connectNextBlockly(otherBlockly: Blockly?) {
        if self.nextConnection?.targetConnection?.sourceBlock == otherBlockly {
            /** No change in next blockly */
            
        } else if self.previousConnection?.targetConnection?.sourceBlock == otherBlockly {
            /** otherBlockly was my previous blockly */
            
            /** Detach the previous link */
            otherBlockly?.nextConnection?.targetConnection = nil
            self.previousConnection?.targetConnection = nil

            /** Attach otherBlockly as my next blockly */
            otherBlockly?.previousConnection?.targetConnection = self.nextConnection
            self.nextConnection?.targetConnection = otherBlockly?.previousConnection
        
        } else if otherBlockly?.previousConnection?.targetConnection != nil {
            /** Already have a next blockly */
            
        } else {
            /** Attach to the next blockly */
            self.nextConnection?.targetConnection?.targetConnection = nil
            self.nextConnection?.targetConnection = otherBlockly?.previousConnection
            otherBlockly?.previousConnection?.targetConnection = self.nextConnection
        }
        otherBlockly?.snapToNeighbour()
    }
    
    
    /**
        Update PreviousBlockly
    
        :param: otherBlockly reference to the new blockly or nil to disconnect from the previous blockly
     */
    public func connectPreviousBlockly(otherBlockly: Blockly?) {
        if self.previousConnection?.targetConnection?.sourceBlock == otherBlockly {
            /** No Change in Previous Blockly */
            
        } else if otherBlockly?.nextConnection?.targetConnection != nil {
            /** otherBlockly Already have a next blockly */
            let orphanBlock = otherBlockly?.nextConnection?.targetConnection?.sourceBlock
            /** Detach the orginal next blockly of otherBlockly */
            otherBlockly?.nextConnection?.targetConnection = nil
            orphanBlock?.previousConnection?.targetConnection = nil
            /** Attach me to the next blockly of otherBlockly */
            otherBlockly?.nextConnection?.targetConnection = self.previousConnection
            self.previousConnection?.targetConnection = otherBlockly?.nextConnection
            /** Try to attach the orphan block back to my tail */
            if let lastConnection = lastBlockly.nextConnection {
                lastConnection.targetConnection = orphanBlock?.previousConnection
                orphanBlock?.previousConnection?.targetConnection = lastConnection
            }
            
        } else {
            /** Attach to the previous blockly */
            self.previousConnection?.targetConnection?.targetConnection = nil
            self.previousConnection?.targetConnection = otherBlockly?.nextConnection
            otherBlockly?.nextConnection?.targetConnection = self.previousConnection
        }
        snapToNeighbour()
    }
    
    
    /**
        Update my center such that my previous connection position is always stick to the next connection of my previous blockly
     */
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
     
        :param: type Input type of the input
     
        :param: field String to be displayed
     */
    func appendInput(type: InputType, field: String) {
        inputs.append(Input(sourceBlock: self, type: type, field: field))
    }
    
    /**
        Remove Input at @index
     
        :param: index: index of input to be removed
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
