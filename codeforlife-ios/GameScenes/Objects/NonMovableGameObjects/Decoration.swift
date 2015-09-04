//
//  Decoration.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 13/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class Decoration: GameObject {
    
    init(imageNamed: String, position: CGPoint) {
        let width: CGFloat
        let height: CGFloat
        switch imageNamed {
            case "tree1":   width = GameMapConfig.GridSize.width
                            height = GameMapConfig.GridSize.height * 109/123
            case "tree2" :  width = GameMapConfig.GridSize.width
                            height = GameMapConfig.GridSize.height * 85/87
            case "bush":    width = GameMapConfig.GridSize.width * 55/123
                            height = GameMapConfig.GridSize.height * 55/123
            default:        width = GameMapConfig.GridSize.width
                            height = GameMapConfig.GridSize.height
        }
        super.init(imageNamed: imageNamed, width: width, height: height, rotation: 0)
        self.position = position
        self.zPosition = 0.5
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}