//
//  Blockly.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class Blockly: UIView, BlocklyUIDelegate {
    
    public let blocklyCore: BlocklyCore
    
    public weak var viewController: BlocklyViewController?
    
    public var previousConnectionPoint: PreviousConnectionPoint?
    public var nextConnectionPoint: NextConnectionPoint?
    public var outputConnectionPoint: OutputConnectionPoint?
    
    public var inputs = [Input]() {
        didSet {
            inputDidChange()
        }
    }
    
    public var deletable = true
    public var editable = true
    public var movable = true

    public var isSelected = false {
        didSet {
            changeBlocklyUIState(isSelected ? .Selected : .None)
            if !isSelected {
                self.updateNeighbour()
            }
        }
    }
    
    public var isHighlighted = false {
        didSet {
            changeBlocklyUIState(isHighlighted ? .Highlighted : .None)
        }
    }
    
    public var isError = false {
        didSet {
            changeBlocklyUIState(isError ? .Error : .None)
        }
    }
    
    public var isWarning = false {
        didSet {
            changeBlocklyUIState(isWarning ? .Warning : .None)
        }
    }
    
    public let shapeLayer = CAShapeLayer()
    
    override public var center: CGPoint {
        didSet {
            updateConnectionPointPosition()
        }
    }
    
    public init(buildClosure: (Blockly) -> Void) {
        self.blocklyCore = BlocklyCore()
        super.init(frame: CGRect(origin: CGPointZero, size: CGSizeZero))
        self.blocklyCore.blockly = self
        Workspace.blocklys.append(self.blocklyCore)
        self.frame.size = DefaultBlocklySize
        self.backgroundColor = UIColor.clearColor()
        self.center = DefaultBlocklyCenter
        self.blocklyCore.setNextStatement(true)
        self.blocklyCore.setPreviousStatement(true)
        self.setupShapeLayer()
        buildClosure(self)
        render()
    }
    
    private func setupShapeLayer() {
        layer.addSublayer(shapeLayer)
        shapeLayer.fillColor = DefaultBlocklyBackgroundColor.CGColor
        shapeLayer.strokeColor = UIColor.grayColor().CGColor
        shapeLayer.zPosition = -1
    }
    
    func render() {
        frame.size.height = calculateFrameHeight()
        subviews.foreach({$0.removeFromSuperview()})
        inputs.foreach({[unowned self] in self.addSubview($0)})
        updateInputsFrame()
        shapeLayer.path = BlocklyDrawer.createCGPath(self)
        parentBlockly?.render()
        updateConnectionPointPosition()
    }
    
    private func changeBlocklyUIState(state: BlocklyUIState) {
        switch state {
        case .None:
            layer.zPosition = 0
            shapeLayer.lineWidth = 1
            shapeLayer.strokeColor = UIColor.grayColor().CGColor
        case .Highlighted:
            layer.zPosition = 1
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.greenColor().CGColor
        case .Selected:
            layer.zPosition = 1
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.orangeColor().CGColor
        case .Error:
            layer.zPosition = 1
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.redColor().CGColor
        case .Warning:
            layer.zPosition = 1
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.yellowColor().CGColor
            
        }
    }
    
    private func updateConnectionPointPosition() {
        nextConnectionPoint?.position = frame.origin + CGPointMake(0, frame.height-TabSize.height) + NextConnectionOffset
        previousConnectionPoint?.position = frame.origin + PreviousConnectionOffset
        outputConnectionPoint?.position = frame.origin + CGPointMake(0, BlankSize.height + DefaultBlocklySize.height/2)
        inputs.foreach({$0.connectionPoint?.updateTargetConnectionPosition()})
    }
    
    private func calculateFrameHeight() -> CGFloat {
        var result = max(DefaultBlocklySize.height, inputs.reduce(0, combine: {$0 + $1.totalHeight}))
        return result + TabSize.height + BlankSize.height
    }
    
    func updateInputsFrame() {
        for (index, input) in enumerate(inputs) {
            /** Adjust position */
            let x = TabSize.height + InputOffset
            let y = index < 1 ? BlankSize.height : inputs[index-1].frame.origin.y + inputs[index-1].totalHeight
            input.frame.origin = CGPointMake(x, y)
            
            /** Adjust width */
            input.frame.size.width = self.frame.width - InputOffset - TabSize.height * 2
        }
    }
    
    func findHighlightConnection() -> ConnectionPoint? {
        let closestConnectionPointInfo: ConnectionPointInfo?
        if blocklyCore.nextConnection?.targetConnection != nil {
            // MARK: Never highlight connected next blockly
            closestConnectionPointInfo = bestOf(closestNextConnectionPointInfo, closestInputConnectionPointInfo)
        } else {
            closestConnectionPointInfo = bestOf(closestPreviousConnectionPointInfo, closestNextConnectionPointInfo, closestInputConnectionPointInfo)
        }
        return closestConnectionPointInfo != nil ? closestConnectionPointInfo!.0 : nil
    }
    
    func updateNeighbour() {
        updateOutputBlockly()
        updatePreviousBlockly()
        updateNextBlockly()
    }
    
    private func updateOutputBlockly() {
        self.blocklyCore.outputConnection?.connect(closestInputConnectionPoint?.connection)
        self.outputConnectionPoint?.targetConnectionPoint = closestInputConnectionPoint
    }
    
    private func updatePreviousBlockly() {
        self.blocklyCore.previousConnection?.connect(closestNextConnectionPoint?.connection)
        self.previousConnectionPoint?.targetConnectionPoint = closestNextConnectionPoint
    }
    
    private func updateNextBlockly() {
        self.blocklyCore.nextConnection?.connect(closestPreviousConnectionPoint?.connection)
        self.nextConnectionPoint?.targetConnectionPoint = closestPreviousConnectionPoint
    }
    
    func bump() {
        UIView.animateWithDuration(BumpDuration, animations: {
            [unowned self] in
            let offsetX = self.frame.width*BumpOffsetRatio
            let offsetY = self.frame.height*BumpOffsetRatio
            let offset = CGPointMake(offsetX, offsetY)
            self.center = self.center + offset
        })
    }
    
    public func removeFromWorkspace(force: Bool) {
        if (force || deletable) {
            inputs.foreach({$0.targetBlockly?.removeFromWorkspace(force)})
            nextBlockly?.removeFromWorkspace(force)
            blocklyCore.removeFromWorkspace()
            self.removeFromSuperview()
        }
    }
    
    public func findInputByInputConnection(connection: InputConnection?) -> Input? {
        if let connection = connection {
            for (index, input) in enumerate(inputs) {
                if input.connectionPoint?.connection === connection {
                    return input
                }
            }
        }
        return nil
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.blocklyCore = BlocklyCore()
        super.init(coder: aDecoder)
    }

}
