//
//  GameVanDeliverAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class GameVanDeliverAction: Animation {
    
    var destinationId: Int
    
    init(delegate: GameViewControllerDelegate?, destinationId: Int) {
        self.destinationId = destinationId
        super.init(delegate: delegate)
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        print("Van Deliver")
        delegate?.deliver(destinationId, completion: completion)
    }
}