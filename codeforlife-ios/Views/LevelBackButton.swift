//
//  LevelBackButton.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class LevelBackButton: UIButton {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        backgroundColor = kC4LEpisodeBackgroundColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderColor = kC4LEpisodeBorderColor.CGColor
        layer.borderWidth = 8
    }

}
