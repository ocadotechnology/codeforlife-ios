//
//  PreviousConnectionPoint.swift
//  Pods
//
//  Created by Joey Chan on 20/08/2015.
//
//

import Foundation

public class PreviousConnectionPoint: ConnectionPoint {
    
    let sourceBlockly: UIBlocklyView
    var position: CGPoint
    var connection: Connection {
        return sourceBlockly.blockly.previousConnection!
    }
    weak var targetConnectionPoint: ConnectionPoint?
    
    init(_ sourceBlockly: UIBlocklyView) {
        self.sourceBlockly = sourceBlockly
        self.position = sourceBlockly.frame.origin + PreviousConnectionOffset
    }
    
    func updateSourceBlockCenter() {
        sourceBlockly.frame.origin = position - PreviousConnectionOffset
        sourceBlockly.center = sourceBlockly.frame.origin + CGPointMake(sourceBlockly.frame.width/2, sourceBlockly.frame.height/2)
    }
    
    func findClosestConnectionPointResult(connectionPoints: [ConnectionPoint], _ searchRadius: CGFloat) -> (ConnectionPoint, CGFloat)? {
        var closest: ConnectionPoint?
        var shortestDistance: CGFloat = -1
        for otherConnectionPoint in sourceBlockly.viewController!.connectionPoints {
            if  distanceTo(otherConnectionPoint) < searchRadius &&
                connection.matchSearchCondition(otherConnectionPoint.connection) {
                    if closest == nil || distanceTo(otherConnectionPoint) < shortestDistance {
                        closest = otherConnectionPoint
                        shortestDistance = distanceTo(otherConnectionPoint)
                    }
            }
        }
        return closest != nil ? (closest!, shortestDistance) : nil
    }
    
    func distanceTo(otherConnectionPoint: ConnectionPoint) -> CGFloat {
        return distanceBetween(self, rhs: otherConnectionPoint)
    }
    
    func attemptToConnect(otherConnectionPoint: ConnectionPoint) -> Bool {
        // TODO
        return false
    }
}
