//
//  GameViewCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit

protocol Command {
    func execute<T>(response: T -> Void )
}

class GameViewCommand : Command {
    
    var gameViewController: GameViewController
    
    init(gameViewController: GameViewController ) {
        self.gameViewController = gameViewController
    }
    
    func execute<T>(response: T -> Void) {
        fatalError("Absract GameViewCommand method called")
    }
    
}
