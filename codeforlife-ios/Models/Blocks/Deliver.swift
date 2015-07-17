//
//  Deliver.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 08/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Deliver: Block {
    init() {
        super.init(
            description: "Deliver",
            type: "\"deliver\",",
            color: kC4LBlocklyDeliverBlockColour)
    }
    
    override func executeBlock(#animated: Bool, completion: (() -> Void)?) {
        van?.deliver(animated: animated, completion: completion)
    }

}