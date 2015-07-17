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
    
    weak var van: Van? {
        return SharedContext.MainGameViewController?.gameMapViewController?.map?.van
    }
    
    func executeAnimation(completion: (() -> Void)? = nil) {
        fatalError("Implement executeanimation()")
    }
    
    final func stop() {
        SharedContext.MainGameViewController?.gameMapViewController?.map?.removeAllActions()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.van.removeAllActions()
    }
    
}

