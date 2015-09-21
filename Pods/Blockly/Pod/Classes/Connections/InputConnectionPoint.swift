//
//  InputConnectionPoint.swift
//  Pods
//
//  Created by Joey Chan on 20/08/2015.
//
//

import Foundation

public class InputConnectionPoint: ConnectionPoint {
    
    let sourceInput: Input
    var sourceBlockly: UIBlocklyView {
        return sourceInput.sourceBlocklyView
    }
    let connection: Connection
    weak var targetConnectionPoint: ConnectionPoint?
    var position = CGPointZero
    
    
    init(_ sourceInput: Input, _ connection: InputConnection) {
        self.sourceInput = sourceInput
        self.connection = connection
        self.sourceInput.sourceBlocklyView.blockly.appendInputConnection(connection)
    }
    
    func updateTargetConnectionPosition() {}
    
    func updateSourceBlockCenter() {}
    
    func findClosestConnectionPointResult(connectionPoints: [ConnectionPoint], _ searchRadius: CGFloat) -> (ConnectionPoint, CGFloat)? {
        println("Inputconnections do not findClosestConnectionResult()")
        return nil
    }
    
    func distanceTo(otherConnectionPoint: ConnectionPoint) -> CGFloat {
        return distanceBetween(self, otherConnectionPoint)
    }
    
    func attemptToConnect(otherConnectionPoint: ConnectionPoint) -> Bool {
        println("InputConnections do not initiate connections")
        return false
    }
}
