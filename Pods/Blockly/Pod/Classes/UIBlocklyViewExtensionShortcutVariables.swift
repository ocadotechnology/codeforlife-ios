//
//  BlocklyExtensionReadableVariables.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

/*
    In order to avoid having too many lines of code in one file,
    all read-only shortcut variable reside here
 */
extension UIBlocklyView {
    
    var totalHeight: CGFloat {
        return frame.height - TabSize.height + (nextBlockly?.totalHeight ?? TabSize.height)
    }
    
    unowned var lastBlockly: UIBlocklyView {
        return nextBlockly?.lastBlockly ?? self
    }
    
    weak var nextBlockly: UIBlocklyView? {
        return blockly.nextConnection?.targetConnection?.sourceBlockly.blocklyView
    }
    
    weak var parentBlockly: UIBlocklyView? {
        if let previousTargetConnection = blockly.previousConnection?.targetConnection {
            return previousTargetConnection is InputStatementConnection ?
                previousTargetConnection.sourceBlockly.blocklyView :
                previousTargetConnection.sourceBlockly.blocklyView?.parentBlockly
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
