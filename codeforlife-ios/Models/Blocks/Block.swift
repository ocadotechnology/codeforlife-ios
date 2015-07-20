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
    
    weak var nextBlock: Block?
    var type: String
    var description: String
    var color: UIColor
    
    init(description: String, type:String, color: UIColor) {
        self.description = description
        self.type = type
        self.color = color
    }
    
    func executeBlockAnimation(player: MovableGameObject?, completion: (() -> Void)? = nil) {
        fatalError("Implement executeBlockAnimation")
    }
    
    func executeBlockAction(player: MovableGameObject?, completion: (() -> Void)? = nil) {
        fatalError("Implement executeBlockAction")
    }
    
    func toString() -> String {
        return ""
    }
    
    func submit() {}
    
    func submitMock() {}
}