//
//  BlocklyExtensionReadableVariables.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

extension Blockly {
    
    var totalHeight: CGFloat {
        return frame.height - TabSize.height + (nextBlockly?.totalHeight ?? TabSize.height)
    }
    
    unowned var lastBlockly: Blockly {
        return nextBlockly?.lastBlockly ?? self
    }
    
    weak var nextBlockly: Blockly? {
        return blocklyCore.nextConnection?.targetConnection?.sourceBlock.blockly
    }
    
    weak var parentBlockly: Blockly? {
        if let previousTargetConnection = blocklyCore.previousConnection?.targetConnection {
            return previousTargetConnection is InputStatementConnection ?
                previousTargetConnection.sourceBlock.blockly :
                previousTargetConnection.sourceBlock.blockly?.parentBlockly
        }
        return nil
    }
    
    var connectionPoints: [ConnectionPoint] {
        var connectionPoints = [ConnectionPoint]()
        connectionPoints.appendIfNotNil(previousConnectionPoint)
        connectionPoints.appendIfNotNil(nextConnectionPoint)
        connectionPoints.appendIfNotNil(outputConnectionPoint)
        for input in inputs {
            connectionPoints.appendIfNotNil(input.connectionPoint)
        }
        return connectionPoints
    }
    
    typealias ConnectionPointInfo = (ConnectionPoint, CGFloat)
    var closestPreviousConnectionPointInfo: ConnectionPointInfo? {
        return nextConnectionPoint?.findClosestConnectionPointResult(viewController!.connectionPoints, SearchRadius)
    }
    
    var closestNextConnectionPointInfo: ConnectionPointInfo? {
       return previousConnectionPoint?.findClosestConnectionPointResult(viewController!.connectionPoints, SearchRadius)
    }
    
    var closestInputConnectionPointInfo: ConnectionPointInfo? {
        return outputConnectionPoint?.findClosestConnectionPointResult(viewController!.connectionPoints, SearchRadius)
    }
    
    var closestPreviousConnectionPoint: ConnectionPoint? {
        return closestPreviousConnectionPointInfo?.0
    }
    
    var closestNextConnectionPoint: ConnectionPoint? {
        return closestNextConnectionPointInfo?.0
    }
    
    var closestInputConnectionPoint: ConnectionPoint? {
        return closestInputConnectionPointInfo?.0
    }
    
}
