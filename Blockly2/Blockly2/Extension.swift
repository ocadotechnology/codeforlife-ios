//
//  Extension.swift
//  Blockly2
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Darwin
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