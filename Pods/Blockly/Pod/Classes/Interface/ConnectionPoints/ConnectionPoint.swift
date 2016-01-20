//
//  ConnectionPoint.swift
//  Pods
//
//  Created by Joey Chan on 20/08/2015.
//
//

import Foundation

protocol ConnectionPoint: class {
    
    var sourceBlockly: UIBlocklyView {get}
    var position: CGPoint {get set}
    var connection: Connection {get}
    weak var targetConnectionPoint: ConnectionPoint? {get set}
    
    func updateSourceBlockCenter()
    func findClosestConnectionPointResult(connectionPoints: [ConnectionPoint], _ searchRadius: CGFloat) -> (ConnectionPoint, CGFloat)?
    func distanceTo(otherConnectionPoint: ConnectionPoint) -> CGFloat
    func attemptToConnect(otherConnectionPoint: ConnectionPoint) -> Bool
}