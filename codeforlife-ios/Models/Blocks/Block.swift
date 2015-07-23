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
    
    weak var van: Van? {
        return SharedContext.MainGameViewController?.gameMapViewController?.map?.van
    }
    
    init(description: String, type:String, color: UIColor) {
        self.description = description
        self.type = type
        self.color = color
    }
    
    func executeBlock(#animated: Bool, completion: (() -> Void)?) { completion?() }
    
}