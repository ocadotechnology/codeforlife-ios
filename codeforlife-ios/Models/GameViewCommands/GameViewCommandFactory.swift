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

let moveForwardJavaScript = "$('#moveForward').trigger('click');"
let turnLeftJavaScript = "$('#turnLeft').trigger('click');"
let turnRightJavaScript = "$('#turnRight').trigger('click');"
let goJavaScript = "$('#play_radio').trigger('click');"


class CommandFactory {
    
    static var gameViewController: GameViewController?
    
    class func BlocklyCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewBlocklyCommandJavaScript)
    }
    
    class func ClearCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewClearCommandJavaScript)
    }
    
    class func PlayCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewPlayCommandJavaScript)
    }
    
    class func StopCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewStopCommandJavaScript)
    }
    
    class func StepCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewStepCommandJavaScript)
    }
    
    class func LoadCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewLoadCommandJavaScript)
    }
    
    class func SaveCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewSaveCommandJavaScript)
    }
    
    class func HelpCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewHelpCommandJavaScript)
    }
    
    class func MuteCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewMuteCommandJavaScript)
    }
    
    class func LoadLevelCommand(level: Level, gameViewController: GameViewController = gameViewController!) -> GVLoadLevelCommand {
        return GVLoadLevelCommand(level: level, gameViewController: gameViewController)
        
    }
    
    class func MoveForwardCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: moveForwardJavaScript)
    }
    
    class func TurnLeftCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: turnLeftJavaScript)
    }
    
    class func TurnRightCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: turnRightJavaScript)
    }
    
    
    
    
    
    
}
