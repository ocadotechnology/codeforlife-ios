//
//  GameViewButton.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 21/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class GameViewButton: UIButton {

    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue {
                backgroundColor = kC4LGameViewButtonHighlightedColour
            } else {
                backgroundColor = UIColor.clearColor()
            }
        }
    }
    
//    override var selected: Bool {
//        get {
//            return super.selected
//        }
//        set {
//            if newValue {
//
//            }
//        }
//    }

}
