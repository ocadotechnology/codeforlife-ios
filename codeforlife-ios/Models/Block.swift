//
//  Blocks.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class Block {
    var description: String
    var color: UIColor
    init(description: String, color: UIColor) {
        self.description = description
        self.color = color
    }
}

class Start: Block {
    init() {
        super.init(
            description: "Start",
            color: UIColor.whiteColor())
    }
}

class Forward: Block {
    init() {
        super.init(
            description: "Move Forward",
            color: UIColor.whiteColor())
    }
}

class Left: Block {
    init() {
        super.init(
            description: "Turn Left",
            color: UIColor.whiteColor())
    }
}

class Right: Block {
    init() {
        super.init(
            description: "Right",
            color: UIColor.whiteColor())
    }
}

class Deliver: Block {
    init() {
        super.init(
            description: "Deliver",
            color: UIColor.whiteColor())
    }
}