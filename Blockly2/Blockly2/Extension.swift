//
//  Extension.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

func +(lhs:CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x+rhs.x, lhs.y+rhs.y)
}

func +=(lhs: CGPoint?, rhs: CGPoint?) -> CGPoint? {
    if let lhs = lhs, rhs = rhs {
        return CGPointMake(lhs.x+rhs.x, lhs.y+rhs.y)
    }
    return lhs ?? rhs
}

func -(lhs:CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x-rhs.x, lhs.y-rhs.y)
}

func distanceBetween(lhs: CGPoint, rhs: CGPoint) -> CGFloat {
    return sqrt((lhs.x-rhs.x)*(lhs.x-rhs.x) + (lhs.y-rhs.y)*(lhs.y-rhs.y))
}

func distanceBetween(lhs: Connection, rhs: Connection) -> CGFloat {
    return distanceBetween(lhs.position, rhs.position)
}

func betterOf(lhs: (Connection, CGFloat)?, rhs: (Connection, CGFloat)?) -> (Connection, CGFloat)? {
    if lhs != nil && rhs != nil {
        return lhs!.1 < rhs!.1 ? lhs : rhs
    }
    return lhs ?? rhs
}

func bestOf(args: (Connection, CGFloat)?...) -> (Connection, CGFloat)? {
    var minimum: (Connection, CGFloat)?
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
    
}

extension CGSize {
    
    func toCGPoint() -> CGPoint {
        return CGPointMake(self.width, self.height)
    }
    
}