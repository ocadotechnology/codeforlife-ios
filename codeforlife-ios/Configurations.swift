//
//  GlobalConfig.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

let DefaultMode = Mode.Development
let WebViewEnabled = true

let DevUsername = "trial"
let DevPassword = "cabbage"

enum Mode {
    case Development
    case Mock
    case Normal
}

struct GameMapConfig {
    
    // No size effect when MapScene is using AspectFill or AspectFit
    static let GridSize = CGSize(width: 70, height: 70)
    
    // Tuned Value
    static let straightToTurnRatio: CGFloat = 1.24
    
    // Offset from the origin of the Grid at (0, 0) from the origin of the MapScene
    static let MapOffset = CGPointMake(3*GridSize.width, GridSize.height)
    
    /*
        Currently the decorations data are designed for the web version which makes their
        coordinates in mapScene really weird, hence extra tuning is needed which leads to the
        below variables
     */
    // Size for all the decorations
    static let DecorationRatio = CGPointMake(0.7, 0.7)

    // Offset from the origin on the MapScene
    static let DecorationOffsetRatio = CGPointMake(0.525, 0.525)
    
}
