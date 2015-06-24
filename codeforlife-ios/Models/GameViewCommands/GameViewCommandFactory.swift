//
//  CommandFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 22/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit

let kC4LGameViewClearCommandJavaScript   = "ocargo.blocklyControl.reset();" + "ocargo.game.reset();"
let kC4LGameViewHelpCommandJavaScript    = "$('#help_radio').trigger('click');"
let kC4LGameViewLoadCommandJavaScript    = "$('#load_radio').trigger('click');"
let kC4LGameViewMuteCommandJavaScript    = "$('#mute_radio').trigger('click');"
let kC4LGameViewPlayCommandJavaScript    = "$('#play_radio').trigger('click');"
let kC4LGameViewSaveCommandJavaScript    = "$('#save_radio').trigger('click');"
let kC4LGameViewStepCommandJavaScript    = "$('#step_radio').trigger('click');"
let kC4LGameViewStopCommandJavaScript    = "$('#stop_radio').trigger('click');"
let kC4LGameViewBlocklyCommandJavaScript = "$('#blockly_radio').trigger('click');"


class GameViewCommandFactory {
    
    static var gameViewController: GameViewController?
    
    static func BlocklyCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewBlocklyCommandJavaScript)
    }
    
    static func ClearCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewClearCommandJavaScript)
    }
    
    static func PlayCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewPlayCommandJavaScript)
    }
    
    static func StopCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewStopCommandJavaScript)
    }
    
    static func StepCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewStepCommandJavaScript)
    }
    
    static func LoadCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewLoadCommandJavaScript)
    }
    
    static func SaveCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewSaveCommandJavaScript)
    }
    
    static func HelpCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewHelpCommandJavaScript)
    }
    
    static func MuteCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewMuteCommandJavaScript)
    }
    
    static func LoadLevelCommand(level: Level, gameViewController: GameViewController = gameViewController!) -> GVLoadLevelCommand {
        return GVLoadLevelCommand(level: level, gameViewController: gameViewController)
        
    }
    
}
