//
//  Deliver.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class DeliverAnimation: Animation {
    
    var destinationId: Int
    
    init(destinationId: Int) {
        self.destinationId = destinationId
    }
    
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Deliver")
        if let map = SharedContext.MainGameViewController?.gameMapViewController?.map {
            map.destinations[destinationId].visited = true
            completion?()
        }
    }
}