//
//  LevelNavigationButton.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 22/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class EpisodeNavigationButton: UIButton {
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
}
