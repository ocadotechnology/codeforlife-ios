//
//  Deliver.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class DeliverAnimation: Animation {
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Van Deliver")
        CommandFactory.NativeDeliverCommand().execute(completion: completion)
    }
}