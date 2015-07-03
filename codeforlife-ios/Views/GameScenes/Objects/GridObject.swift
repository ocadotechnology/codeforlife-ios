//
//  GridObject.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation


class GridObject: SKSpriteNode  {

    init( _ imageName: String) {
        let texture = SKTexture(image: UIImage(named: imageName)!)
        super.init(texture: texture, color: nil, size: CGSize(width: 50, height: 50))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}