//
//  onStopControlsAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class OnStopControlsAction: Animation {
    override func execute(completion: (() -> Void)? = nil) {
        println("OnStopControls")
        delegate?.onStopControls(completion)
    }
}