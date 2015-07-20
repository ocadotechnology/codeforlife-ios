//
//  HighlightAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class HighlightAnimation: Animation {
    
    let blockId: Int
    
    init(blockId: Int) {
        self.blockId = blockId
    }
    
    override func executeAnimation(completion: (() -> Void)? = nil) {
//        fatalError("HighlightAnimation")
        println("Highlightanimation")
        completion?()
    }
}