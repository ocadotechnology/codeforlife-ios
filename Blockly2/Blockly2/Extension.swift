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

func -(lhs:CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x-rhs.x, lhs.y-rhs.y)
}

func distanceBetween(lhs: CGPoint, rhs: CGPoint) -> CGFloat {
    return sqrt((lhs.x-rhs.x)*(lhs.x-rhs.x) + (lhs.y-rhs.y)*(lhs.y-rhs.y))
}

func distanceBetween(lhs: Connection, rhs: Connection) -> CGFloat {
    return distanceBetween(lhs.position, rhs.position)
}

func min2(lhs: (Connection, CGFloat)?, rhs: (Connection, CGFloat)?) -> (Connection, CGFloat)? {
    if lhs != nil && rhs != nil {
        return lhs!.1 < rhs!.1 ? lhs : rhs
    }
    return lhs ?? rhs
}

func min(args: (Connection, CGFloat)?...) -> (Connection, CGFloat)? {
    var minimum: (Connection, CGFloat)?
    args.foreach({minimum = min2(minimum, $0)})
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