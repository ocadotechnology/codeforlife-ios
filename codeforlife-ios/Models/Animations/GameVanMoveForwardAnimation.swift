//
//  MoveForward.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class GameVanMoveForwardAction: Animation {
    override func execute(completion: (() -> Void)? = nil) {
        print("Van Move Forward")
        delegate?.vanMoveForward(completion)
    }
    
}