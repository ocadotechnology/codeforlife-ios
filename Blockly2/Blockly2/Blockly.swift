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
    let shapeLayer = CAShapeLayer()
    
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
            nextConnection?.position = frame.origin + CGPointMake(frame.width/2, frame.height)
            previousConnection?.position = frame.origin + CGPointMake(frame.width/2, 0)
            outputConnection?.position = frame.origin + CGPointMake(0, frame.height/2)
            inputs.foreach({$0.connection?.updateTargetConnectionPosition()})
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
    
    /**
        Return the last blockly in my blockly chain
     */
    var lastBlockly: Blockly {
        return nextBlockly?.lastBlockly ?? self
    }
    
    /**
        Return my next blockly if one exists
     */
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
        self.backgroundColor = UIColor.clearColor()
        self.shapeLayer.fillColor = defaultColor.CGColor
        self.shapeLayer.strokeColor = UIColor.grayColor().CGColor
        self.shapeLayer.zPosition = -1
        self.layer.addSublayer(shapeLayer)
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
        Update the view of the blockly
     */
    func render() {
        /** Calculate and update the height of the blockly */
        let newHeight = max(minimalSize.height + 10 + 10, CGFloat(inputs.count)*defaultSize.height + 10 + 10)
        let oldOrigin = frame.origin
        frame.size.height = newHeight
        frame.origin = oldOrigin
        
        /** Remove all the Inputs and redisplay them */
        subviews.foreach({$0.removeFromSuperview()})
        inputs.foreach({[unowned self] in self.addSubview($0)})
        updateInputsFrame()
    }
    
    /**
        Reposition all the subviews and resize their widths to follow the blockly frame width
     */
    func updateInputsFrame() {
        for (index, input) in enumerate(inputs) {
            /** Adjust position */
            input.frame.origin = CGPointMake(0, CGFloat(index) * defaultSize.height + 10)
            /** Adjust width */
            input.frame.size.width = self.frame.width
        }
    }
    
    /**
        Locate the cloest contact point for each valid contact point of this blockly and update connetions
     */
    func updateNeighbour() {
        let connections = workspace!.connections
        
        let newOutputConnection = self.outputConnection?.findClosestConnectionResult(connections, searchRadius, includeConnected: true)?.0
        self.outputConnection?.connect(newOutputConnection)
        
        let newPreviousConnection = self.previousConnection?.findClosestConnectionResult(connections, searchRadius, includeConnected: true)?.0
        self.previousConnection?.connect(newPreviousConnection)
        
        let newNextConnection = self.nextConnection?.findClosestConnectionResult(connections, searchRadius, includeConnected: true)?.0
        self.nextConnection?.connect(newNextConnection)
    }
    
    /**
        Find the closest connection to be highlighted
     */
    func findHighlightConnection() -> Connection? {
        let connections = workspace!.connections
        let nextConnectionResult = nextConnection?.findClosestConnectionResult(connections, searchRadius, includeConnected: true)
        let previousConnectionResult = previousConnection?.findClosestConnectionResult(connections, searchRadius, includeConnected: true)
        let outputConnectionResult = outputConnection?.findClosestConnectionResult(connections, searchRadius, includeConnected: true)
        var closestResult = bestOf(nextConnectionResult, previousConnectionResult, outputConnectionResult)
        
        // Never highlight connected next blockly
        if nextConnection?.targetConnection != nil {
            closestResult = bestOf(previousConnectionResult, outputConnectionResult)
        }
        return closestResult != nil ? closestResult!.0 : nil
    }
    
    /**
        Update Next Blockly
    
        :param: otherBlockly reference to the new blockly or nil to disconnect from the next blockly
     */
    func connectNextBlockly(otherBlockly: Blockly?) {
        nextConnection?.connect(otherBlockly?.previousConnection)
    }
    
    
    /**
        Update PreviousBlockly
    
        :param: otherBlockly reference to the new blockly or nil to disconnect from the previous blockly
     */
    func connectPreviousBlockly(otherBlockly: Blockly?) {
        previousConnection?.connect(otherBlockly?.nextConnection)
    }
    
    
    func bump() {
        let offset = CGPointMake(frame.width*1.5, frame.height*1.5)
        center = center + offset
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
        render()
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
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(20, 0))
        path.addLineToPoint(CGPointMake(30, 10))
        path.addLineToPoint(CGPointMake(40, 0))
        path.addLineToPoint(CGPointMake(frame.width, 0))
        path.addLineToPoint(CGPointMake(frame.width, frame.height-10))
        path.addLineToPoint(CGPointMake(40, frame.height-10))
        path.addLineToPoint(CGPointMake(30, frame.height))
        path.addLineToPoint(CGPointMake(20, frame.height-10))
        path.addLineToPoint(CGPointMake(0, frame.height-10))
        path.closePath()
        path.stroke()
        path.fill()
        shapeLayer.path = path.CGPath
    }
    
    required public init(coder aDecoder: NSCoder) {
        minimalSize = defaultSize
        allowNextStatement = true
        allowPreviousStatement = true
        super.init(coder: aDecoder)
    }

}
