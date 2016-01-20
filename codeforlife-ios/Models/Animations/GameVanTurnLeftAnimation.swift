//
//  File.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class GameVanTurnLeftAction: Animation {
    override func execute(completion: (() -> Void)? = nil) {
        print("Van Turn Left")
        delegate?.vanTurnLeft(completion)
    }
    
}
