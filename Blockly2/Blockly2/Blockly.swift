//
//  Blockly.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class Blockly: UIView {
    
    typealias WorkSpace = BlocklyViewController
    weak var workspace: WorkSpace?

    let defaultSize = CGSizeMake(150, 40)
    let defaultCenter = CGPointMake(400, 400)
    let defaultColor = UIColor(red: 64/255, green: 208/255, blue: 192/255, alpha: 1) //#40D0C0
    let searchRadius:CGFloat = 20
    
    var minimalSize: CGSize
    
    var inputs = [Input]() {
        didSet { render() }
    }
    
    var previousConnection: PreviousConnection?
    var nextConnection: NextConnection?
    var outputConnection: OutputConnection?
    
    /**
        Center of the blockly
        
        Upon changes, update next blockly position
     */
    override public var center: CGPoint {
        didSet {
            nextConnection?.position = center + CGPointMake(0, frame.height/2)
            previousConnection?.position = center  + CGPointMake(0, -frame.height/2)
            outputConnection?.position = center + CGPointMake(-frame.width/2, 0)
            updateNextBlocklyPosition()
        }
    }
    
    /**
        Return a list of all the connections this blockly consists of
     */
    var connections: [Connection] {
        var connections = [Connection]()
        connections.appendIfNotNil(nextConnection)
        connections.appendIfNotNil(previousConnection)
        inputs.foreach({connections.appendIfNotNil($0.connection)})
        return connections
    }
    
    /**
        This blockly is allowed to have a next statement by default
     */
    var allowNextStatement = true {
        didSet { self.nextConnection = allowNextStatement ? createNextConnection() : nil }
    }
    
    /**
        This blockly is allowed to have a previous statement by default
     */
    var allowPreviousStatement = true {
        didSet { self.previousConnection = allowPreviousStatement ? createPreviousConnection() : nil }
    }
    
    var lastBlockly: Blockly {
        return nextBlockly?.lastBlockly ?? self
    }
    
    var nextBlockly: Blockly? {
        return nextConnection?.targetConnection?.sourceBlock
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
    private func createNextConnection() -> NextConnection {
        let position = center + CGPointMake(0, frame.height/2)
        let connection = NextConnection(self, position)
        return connection
    }
    
    /**
        Create a Previous Connection
     */
    private func createPreviousConnection() -> PreviousConnection {
        let position = center + CGPointMake(0, -frame.height/2)
        let connection = PreviousConnection(self, position)
        return connection
    }
    
    /**
    Update next blockly's previous contact point to stick to my next contact point
    */
    func updateNextBlocklyPosition() {
        nextConnection?.targetConnection?.sourceBlock.snapToNeighbour()
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

        inputs.foreach({[unowned self] in self.addSubview($0)})
        
        updateInputsFrame()
    }
    
    /**
        Reposition all the subviews and resize their widths to follow the blockly frame width
     */
    func updateInputsFrame() {
        for (index, input) in enumerate(inputs) {
            /** Adjust position */
            input.frame.origin = CGPointMake(0, CGFloat(index) * defaultSize.height)
            /** Adjust width */
            input.frame.size.width = self.frame.width
        }
    }
    
    /**
        Removed all subviews
     */
    private func removeAllSubviews() {
        subviews.foreach({$0.removeFromSuperview()})
    }
    
    /**
        Locate the cloest contact point for each valid contact point of this blockly and update connetions
     */
    func updateNeighbour() {
        let includeConnected = true
        PreviousBlocklyUpdated()
        NextBlocklyUpdated()
        OutputBlocklyUpdated()
    }
    
    /**
        Update any change in Previous Blockly
        
        :returns: true if previous blockly has changes, false otherwise
     */
    private func PreviousBlocklyUpdated() -> Bool {
        let connections = workspace!.connections
        let oldPreviousBlockly = self.previousConnection?.targetConnection?.sourceBlock
        let newPreviousBlockly = self.previousConnection?.findClosestAvailableConnection(connections, searchRadius, includeConnected: true)?.0.sourceBlock
        self.connectPreviousBlockly(newPreviousBlockly)
        return oldPreviousBlockly != newPreviousBlockly && newPreviousBlockly != nil
    }
    
    private func NextBlocklyUpdated() -> Bool {
        let connections = workspace!.connections
        let oldNextBlockly = self.nextConnection?.targetConnection?.sourceBlock
        let newNextBlockly = self.nextConnection?.findClosestAvailableConnection(connections, searchRadius, includeConnected: true)?.0.sourceBlock
        println(newNextBlockly)
        self.connectNextBlockly(newNextBlockly)
        return oldNextBlockly != newNextBlockly && newNextBlockly != nil
    }
    
    private func OutputBlocklyUpdated() -> Bool {
        let connections = workspace!.connections
        let oldOutputBlockly = self.outputConnection?.targetConnection?.sourceBlock
        let newOutputBlockly = self.outputConnection?.findClosestAvailableConnection(connections, searchRadius, includeConnected: true)?.0.sourceBlock
        // TODO connect blockly
        return false
    }
    
    
    /**
     Find the connection point which is closest to any connection point of this blockly
     */
    func findClosestAvailableConnection() -> Connection? {
        let connections = workspace!.connections
        let nextConnectionResult = nextConnection?.findClosestAvailableConnection(connections, searchRadius, includeConnected: true)
        let previousConnectionResult = previousConnection?.findClosestAvailableConnection(connections, searchRadius, includeConnected: true)
        let outputConnectionResult = outputConnection?.findClosestAvailableConnection(connections, searchRadius, includeConnected: true)
        let closestResult = min(nextConnectionResult, previousConnectionResult, outputConnectionResult)
        return closestResult != nil ? closestResult!.0 : nil
    }
    
    /**
        Update Next Blockly
    
        :param: otherBlockly reference to the new blockly or nil to disconnect from the next blockly
     */
    private func connectNextBlockly(otherBlockly: Blockly?) {
        if self.nextConnection?.targetConnection?.sourceBlock == otherBlockly {
            /** No change in next blockly */
            
        } else {
            /** There are changes in next blockly */
            if self.previousConnection?.targetConnection?.sourceBlock == otherBlockly {
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
    }
    
    
    /**
        Update PreviousBlockly
    
        :param: otherBlockly reference to the new blockly or nil to disconnect from the previous blockly
     */
    private func connectPreviousBlockly(otherBlockly: Blockly?) {
        if self.previousConnection?.targetConnection?.sourceBlock == otherBlockly {
            /** No Change in Previous Blockly */
        } else {
            /** There are changes in previous blockly */
            
            if self.previousConnection?.targetConnection != nil {
                /** I already have a previous blockly */
                
                /** Detach the original previous blockly */
                self.previousConnection?.targetConnection?.targetConnection = nil
                self.previousConnection?.targetConnection = nil
                println("1")
            }
            
            if otherBlockly?.nextConnection?.targetConnection != nil {
                
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
                    /** Possible to attach the orphan block */
                    lastConnection.targetConnection = orphanBlock?.previousConnection
                    orphanBlock?.previousConnection?.targetConnection = lastConnection
                } else {
                    /** Next Statement is not allowed in the last blockly */
                    orphanBlock?.center += orphanBlock?.frame.size.toCGPoint() ?? CGPointZero
                }
                println("2")
                
            } else {
                /** Attach to the previous blockly */
                self.previousConnection?.targetConnection?.targetConnection = nil
                self.previousConnection?.targetConnection = otherBlockly?.nextConnection
                otherBlockly?.nextConnection?.targetConnection = self.previousConnection
                println("3")
            }
        }
        snapToNeighbour()
    }
    
    /**
        Update my center such that my previous connection position is always stick to the next connection of my previous blockly
     */
    private func snapToNeighbour() {
        let previousBlockly = previousConnection?.targetConnection?.sourceBlock
        let newPosition = previousBlockly?.nextConnection?.position
        if let newPosition = newPosition {
            self.previousConnection?.position = newPosition
            self.previousConnection?.updateSourceBlockCenter()
        }
        updateNextBlocklyPosition()
    }
    
    /**
        Add a new Input to the blockly
     
        :param: type Input type of the input
     
        :param: field String to be displayed
     */
    func appendInput(type: InputType, field: String) {
        let input = Input(sourceBlock: self, type: type, field: field)
        if let lastInput = inputs.last {
            input.frame.origin = lastInput.frame.origin + CGPointMake(0, lastInput.frame.height)
        }
        inputs.append(Input(sourceBlock: self, type: type, field: field))
    }
    
    /**
        Create Output Connection and disable Next Statement to be inserted
     */
    func addOutput() {
        let position = center + CGPointMake(-frame.width/2, 0)
        outputConnection = OutputConnection(self, position)
        allowNextStatement = false
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
