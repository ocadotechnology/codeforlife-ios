//
//  GameViewPopUpAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class GameViewPopUpAction: Animation {
    
    var popupMessage: String
    
    init(message: String, delegate: GameViewControllerDelegate?) {
        self.popupMessage = message
        super.init(delegate: delegate)
    }
    
    override func execute(completion: (() -> Void)? = nil) {
        print("Popup")
        completion?()
    }
}

class WinPopupAction: GameViewPopUpAction {
    
    var pathScore: Float
    var instrScore: Float
    var maxPathScore: Int
    var maxInstrScore: Int
    
    init(delegate: GameViewControllerDelegate?, message: String, pathScore: Float, maxPathScore: Int, instrScore: Float, maxInstrScore: Int) {
        self.pathScore = pathScore
        self.instrScore = instrScore
        self.maxPathScore = maxPathScore
        self.maxInstrScore = maxInstrScore
        super.init(message: message, delegate: delegate)
    }
    
    override func execute(completion: (() -> Void)?) {
        print("Win Popup")
        delegate?.winPopup(popupMessage, pathScore, maxPathScore, instrScore, maxInstrScore, completion: completion)
    }
}

class FailurePopupAction: GameViewPopUpAction {
    override func execute(completion: (() -> Void)?) {
        print("Failure Popup")
        delegate?.failurePopup(popupMessage, completion: completion)
    }
}