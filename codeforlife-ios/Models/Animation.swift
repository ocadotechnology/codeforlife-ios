//
//  Animation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 09/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class Animation {
    
    weak var nextAnimation: Animation?
    var referenceBlock: Int?
    
    func executeAnimation(completion: (() -> Void)? = nil) {
        fatalError("Implement executeanimation()")
    }
    
    func stop() {
        SharedContext.MainGameViewController?.gameMapViewController?.map?.removeAllActions()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.player.removeAllActions()
    }
    
}

