//
//  CommandFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 22/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit
class CommandFactory {
    
    static var gameView: WKWebView? 
    
    static func BlocklyCommand(gameView: WKWebView) -> GameViewCommand {
        return GVBlocklyCommand(gameView: gameView)
    }
    
    static func ClearCommand() -> GameViewCommand {
        return GVClearCommand(gameView: gameView!)
    }
    
    static func PlayCommand() -> GameViewCommand {
        return GVBlocklyCommand(gameView: gameView!)
    }
    
    static func StopCommand() -> GameViewCommand {
        return GVPlayCommand(gameView: gameView!)
    }
    
    static func StepCommand() -> GameViewCommand {
        return GVStepCommand(gameView: gameView!)
    }
    
    static func LoadCommand() -> GameViewCommand {
        return GVLoadCommand(gameView: gameView!)
    }
    
    static func SaveCommand() -> GameViewCommand {
        return GVSaveCommand(gameView: gameView!)
    }
    
    static func HelpCommand() -> GameViewCommand {
        return GVHelpCommand(gameView: gameView!)
    }
    
    static func MuteCommand() -> GameViewCommand {
        return GVMuteCommand(gameView: gameView!)
    }
    
}
