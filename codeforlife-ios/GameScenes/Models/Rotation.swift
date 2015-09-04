//
//  Rotation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 08/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

struct Rotation {
    
    // Dead End
    static let U = CGFloat(M_PI)
    static let D = CGFloat(0)
    static let L = CGFloat(M_PI/2)
    static let R = CGFloat(M_PI*3/2)
    
    // Straight
    static let H = CGFloat(M_PI/2)
    static let V = CGFloat(0)
    
    // Turns
    static let UR = CGFloat(M_PI)
    static let UL = CGFloat(M_PI/2)
    static let DR = CGFloat(M_PI*3/2)
    static let DL = CGFloat(0)
    
    // T Junction
    static let UDL = CGFloat(0)
    static let UDR = CGFloat(M_PI)
    static let ULR = CGFloat(M_PI/2)
    static let DLR = CGFloat(M_PI*3/2)
}
