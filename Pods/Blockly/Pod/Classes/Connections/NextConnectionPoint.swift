//
//  NextConnectionPoint.swift
//  Pods
//
//  Created by Joey Chan on 20/08/2015.
//
//

import Foundation

public class NextConnectionPoint: ConnectionPoint {
    
    let sourceBlockly: Blockly
    var position: CGPoint {
        didSet {
            let targetConnectionPoint = connection.targetConnection?.sourceBlock.blockly?.previousConnectionPoint
            targetConnectionPoint?.position = position
            targetConnectionPoint?.updateSourceBlockCenter()
        }
    }
    var connection: Connection {
        return sourceBlockly.blocklyCore.nextConnection!
    }
    weak var targetConnectionPoint: ConnectionPoint?
    
    init(_ sourceBlockly: Blockly) {
        self.sourceBlockly = sourceBlockly
        self.position = sourceBlockly.frame.origin + CGPointMake(0, sourceBlockly.frame.height - TabSize.height) + NextConnectionOffset
    }
    
    func updateSourceBlockCenter() {
        let frame = sourceBlockly.frame
        sourceBlockly.frame.origin = position - CGPointMake(0, sourceBlockly.frame.height-TabSize.height) - NextConnectionOffset
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
        return distanceBetween(self, otherConnectionPoint)
    }
    
    func attemptToConnect(otherConnectionPoint: ConnectionPoint) -> Bool {
        // TODO
        return false
    }
    
}