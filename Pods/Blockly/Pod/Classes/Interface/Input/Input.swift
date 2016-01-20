//
//  Input.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class Input: UIView {
    
    public var type: InputType
    public unowned var sourceBlocklyView: UIBlocklyView
    public var connectionPoint: InputConnectionPoint?
    
    public var fields = [UIView]() {
        didSet { updateFieldPositions() }
    }
    
    var targetBlockly: UIBlocklyView? {
        return connectionPoint?.connection.targetConnection?.sourceBlockly.blocklyView as? UIBlocklyView
    }
    
    var totalHeight: CGFloat {
        if let inputConnection = connectionPoint?.connection as? InputConnection {
            switch inputConnection {
            case is InputValueConnection:
                if let targetBlockly = connectionPoint?.connection.targetConnection?.sourceBlockly.blocklyView as? UIBlocklyView {
                    return targetBlockly.totalHeight - TabSize.height - BlankSize.height
                }
            case is InputStatementConnection:
                if let targetBlockly = connectionPoint?.connection.targetConnection?.sourceBlockly.blocklyView as? UIBlocklyView {
                    return targetBlockly.totalHeight + ShelfHeight
                }
                return DefaultBlocklySize.height + TabSize.height + BlankSize.height + ShelfHeight
            default: break
            }
        }
        return DefaultInputFrame.height
    }
    
    public init(sourceBlock: UIBlocklyView, type: InputType) {
        self.type = type
        self.sourceBlocklyView = sourceBlock
        super.init(frame: DefaultInputFrame)
        self.backgroundColor = DefaultInputBackgroundColor
        self.setupConnection()
        if let lastInput = sourceBlock.inputs.last {
            frame.origin = lastInput.frame.origin + CGPointMake(0, lastInput.frame.height)
        }
        sourceBlock.inputs.append(self)
        sourceBlock.addSubview(self)
    }
    
    
    public func updateFieldPositions() {
        fields.foreach({$0.sizeToFit()})
        for index in 1 ..< fields.count {
            let previousFrame = fields[index-1].frame
            fields[index].frame.origin = CGPointMake(previousFrame.origin.x + previousFrame.width + 10, previousFrame.origin.y)
        }
        if let lastFrame = fields.last?.frame {
            self.frame.size.width = lastFrame.origin.x + lastFrame.size.width
        }
        sourceBlocklyView.render()
    }
    
    private func setupConnection() {
        switch type {
            case .Value:        self.connectionPoint = InputValueConnectionPoint(self)
            case .Statement:    self.connectionPoint = InputStatementConnectionPoint(self)
            default: break
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.sourceBlocklyView = UIBlocklyView(buildClosure: {$0.center = CGPointZero})
        self.type = .Dummy
        super.init(coder: aDecoder)
    }
    
}
