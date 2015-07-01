//
//  GameViewButton.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class GameViewButton: UIButton {
    
    var isCurrentTab: Bool = false
    
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue {
                backgroundColor = kC4LGameViewButtonHighlightedColour
            } else if !isCurrentTab {
                backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    override var selected: Bool {
        get {
            return isCurrentTab
        }
        set {
            isCurrentTab = newValue
            if newValue {
                backgroundColor = kC4LGameViewButtonSelectedColour
            } else {
                backgroundColor = UIColor.clearColor()
            }
        }
    }

}
