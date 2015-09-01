//
//  Extension.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public func +(lhs:CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x+rhs.x, lhs.y+rhs.y)
}

public func +=(lhs: CGPoint?, rhs: CGPoint?) -> CGPoint? {
    if let lhs = lhs, rhs = rhs {
        return CGPointMake(lhs.x+rhs.x, lhs.y+rhs.y)
    }
    return lhs ?? rhs
}

public func -(lhs:CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x-rhs.x, lhs.y-rhs.y)
}

public func distanceBetween(lhs: CGPoint, rhs: CGPoint) -> CGFloat {
    return sqrt((lhs.x-rhs.x)*(lhs.x-rhs.x) + (lhs.y-rhs.y)*(lhs.y-rhs.y))
}

func distanceBetween(lhs: ConnectionPoint, rhs: ConnectionPoint) -> CGFloat {
    return distanceBetween(lhs.position, rhs.position)
}

func betterOf(lhs: (ConnectionPoint, CGFloat)?, rhs: (ConnectionPoint, CGFloat)?) -> (ConnectionPoint, CGFloat)? {
    if lhs != nil && rhs != nil {
        return lhs!.1 < rhs!.1 ? lhs : rhs
    }
    return lhs ?? rhs
}

func bestOf(args: (ConnectionPoint, CGFloat)?...) -> (ConnectionPoint, CGFloat)? {
    var minimum: (ConnectionPoint, CGFloat)?
    args.foreach({minimum = betterOf(minimum, $0)})
    return minimum
}

extension Array {
    
    mutating func appendIfNotNil(newElement: T?) {
        if let newElement = newElement {
            append(newElement)
        }
    }
    
    func foreach(closure: (T) -> Void) {
        for element in self {
            closure(element)
        }
    }
    
    func foreachBlockly(closure: (Blockly) -> Void) {
        for element in self {
            if let blockly = element as? Blockly {
                closure(blockly)
            }
        }
    }
    
}

extension CGSize {
    
    func toCGPoint() -> CGPoint {
        return CGPointMake(self.width, self.height)
    }
    
}