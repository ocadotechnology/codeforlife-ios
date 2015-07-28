//
//  Extension.swift
//  Blockly
//
//  Created by Joey Chan on 29/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x+rhs.x, lhs.y+rhs.y)
}

func +=(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x+rhs.x, lhs.y+rhs.y)
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x-rhs.x, lhs.y-rhs.y)
}