//
//  Blockly.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class UIBlocklyView: UIView, BlocklyUIDelegate {
    
    public let blockly: Blockly
    public var inputs = [Input]() { didSet { inputDidChange() }  }
    
    let shapeLayer = CAShapeLayer()
    public weak var viewController: BlocklyViewController?
    override public var center: CGPoint { didSet { updateConnectionPointPosition() } }
    
    public var previousConnectionPoint: PreviousConnectionPoint?
    public var nextConnectionPoint: NextConnectionPoint?
    public var outputConnectionPoint: OutputConnectionPoint?
    
    public var mode: Int = BlocklyUIMode.All
    public var state: Int = BlocklyUIState.Normal {
        willSet {
            if state == BlocklyUIState.Selected && newValue != BlocklyUIState.Selected {
                self.updateNeighbour()
            }
        }
        didSet { changeBlocklyUIState(self.state) }
    }
    
    public init(buildClosure: (UIBlocklyView) -> Void) {
        self.blockly = Blockly()
        super.init(frame: CGRect(origin: CGPointZero, size: CGSizeZero))
        self.blockly.blocklyView = self
        self.backgroundColor = UIColor.clearColor()
        self.center = DefaultBlocklyCenter
        self.blockly.setNextStatement(true)
        self.blockly.setPreviousStatement(true)
        self.setupShapeLayer()
        buildClosure(self)
        render()
    }
    
    func render() {
        frame.size.height = calculateFrameHeight()
        frame.size.width = calculateFrameWidth()
        updateInputsFrame()
        shapeLayer.path = BlocklyDrawer.createCGPath(self)
        parentBlockly?.render()
        updateConnectionPointPosition()
    }
    
    func updateInputsFrame() {
        for (index, input) in enumerate(inputs) {
            /** Adjust position */
            let x = TabSize.height + InputOffset
            let y = index < 1 ? BlankSize.height : inputs[index-1].frame.origin.y + inputs[index-1].totalHeight
            input.frame.origin = CGPointMake(x, y)
        }
    }
    
    func findHighlightConnection() -> ConnectionPoint? {
        let closestConnectionPointInfo: ConnectionPointInfo?
        if blockly.nextConnection?.targetConnection != nil {
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
    
    func bump() {
        UIView.animateWithDuration(BumpDuration, animations: {
            [unowned self] in
            let offsetX = self.frame.width*BumpOffsetRatio
            let offsetY = self.frame.height*BumpOffsetRatio
            let offset = CGPointMake(
                self.center.x + offsetX > self.superview!.frame.width ? -offsetX : offsetX,
                self.center.y + offsetY > self.superview!.frame.height ? -offsetY : offsetY)
            self.center = self.center + offset
            })
    }
    
    public func removeFromWorkspace(force: Bool) {
        if (force || (mode & BlocklyUIMode.Deletable != 0)) {
            inputs.foreach({$0.targetBlockly?.removeFromWorkspace(force)})
            nextBlockly?.removeFromWorkspace(force)
            blockly.removeFromWorkspace()
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
    
    private func setupShapeLayer() {
        layer.addSublayer(shapeLayer)
        shapeLayer.fillColor = DefaultBlocklyBackgroundColor.CGColor
        shapeLayer.strokeColor = UIColor.grayColor().CGColor
        shapeLayer.zPosition = -1
    }
    
    private func changeBlocklyUIState(state: Int) {
        switch state {
        case BlocklyUIState.Normal:
            layer.zPosition = 0
            shapeLayer.lineWidth = 1
            shapeLayer.strokeColor = UIColor.grayColor().CGColor
        case BlocklyUIState.Highlighted:
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.greenColor().CGColor
        case BlocklyUIState.Selected:
            layer.zPosition = 1
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.orangeColor().CGColor
        case BlocklyUIState.Error:
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.redColor().CGColor
        case BlocklyUIState.Warning:
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.yellowColor().CGColor
        default: break
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
    
    private func calculateFrameWidth() -> CGFloat {
        return inputs.reduce(DefaultInputFrame.width, combine: {
            (currentMax, input) in
            var newLength = input.frame.width + InputOffset*2
            if input.connectionPoint?.connection is InputStatementConnection {
                newLength = (newLength + PreviousConnectionOffset.x)*4/3
            }
            return max(currentMax, newLength)
        })
    }
    
    private func updateOutputBlockly() {
        self.blockly.outputConnection?.connect(closestInputConnectionPoint?.connection)
        self.outputConnectionPoint?.targetConnectionPoint = closestInputConnectionPoint
    }
    
    private func updatePreviousBlockly() {
        self.blockly.previousConnection?.connect(closestNextConnectionPoint?.connection)
        self.previousConnectionPoint?.targetConnectionPoint = closestNextConnectionPoint
    }
    
    private func updateNextBlockly() {
        self.blockly.nextConnection?.connect(closestPreviousConnectionPoint?.connection)
        self.nextConnectionPoint?.targetConnectionPoint = closestPreviousConnectionPoint
    }
    
    public func foreach(closure: (UIBlocklyView) -> Void) {
        closure(self)
        for input in inputs {
            input.targetBlockly?.foreach(closure)
        }
        nextBlockly?.foreach(closure)
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.blockly = Blockly()
        super.init(coder: aDecoder)
    }

}
