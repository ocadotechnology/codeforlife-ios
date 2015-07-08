//
//  StartAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 14/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class StartAnimation: Animation {
    
    override func executeAnimation(completion: (() -> Void)? = nil) {
        completion?()
    }
}