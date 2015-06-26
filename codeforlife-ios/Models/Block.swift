//
//  Blocks.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Block {
    var description: String
    init() {
        description = "Error"
    }
}

class Start: Block {
    override init() {
        super.init()
        description = "Start"
    }
}

class Forward: Block {
    override init() {
        super.init()
        description = "Move Forward"
    }
}

class Left: Block {
    override init() {
        super.init()
        description = "Turn Left"
    }
}

class Right: Block {
    override init() {
        super.init()
        description = "Turn Right"
    }
}