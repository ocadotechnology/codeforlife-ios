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

let moveForwardJavaScript = "ocargo.blocklyControl.addBlockToEndOfProgram('move_forwards');"
let turnLeftJavaScript = "ocargo.blocklyControl.addBlockToEndOfProgram('turn_left');"
let turnRightJavaScript = "ocargo.blocklyControl.addBlockToEndOfProgram('turn_right');"
let goJavaScript = "$('#play_radio').trigger('click');"
let deliverJavaScript = "ocargo.blocklyControl.addBlockToEndOfProgram('deliver');"


class CommandFactory {
    
    class func WebViewBlocklyCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewBlocklyCommandJavaScript)
    }
    
    class func WebViewClearCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewClearCommandJavaScript)
    }
    
    class func WebViewPlayCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewPlayCommandJavaScript)
    }
    
    class func WebViewStopCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewStopCommandJavaScript)
    }
    
    class func WebViewStepCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewStepCommandJavaScript)
    }
    
    class func WebViewLoadCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewLoadCommandJavaScript)
    }
    
    class func WebViewSaveCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewSaveCommandJavaScript)
    }
    
    class func WebViewHelpCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewHelpCommandJavaScript)
    }
    
    class func WebViewMuteCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: kC4LGameViewMuteCommandJavaScript)
    }
    
    class func WebViewMoveForwardCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: moveForwardJavaScript)
    }
    
    class func WebViewTurnLeftCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: turnLeftJavaScript)
    }
    
    class func WebViewTurnRightCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: turnRightJavaScript)
    }
    
    class func WebViewDeliverCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: StaticContext.MainGameViewController!, javascript: deliverJavaScript)
    }
    
    //Deprecated
    class func WebViewLoadLevelCommand(level: Level) -> GVLoadLevelCommand {
        return GVLoadLevelCommand(level: level, gameViewController: StaticContext.MainGameViewController!)
    }
    
    
    
    
    
    
    class func NativeHelpCommand() -> GameViewCommand {
        return NGVHelpCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeClearCommand() -> GameViewCommand {
        return NGVClearCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeDisableDirectDriveCommand() -> GameViewCommand {
        return NGVDisableDirectDriveCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeEnableDirectDriveCommand() -> GameViewCommand {
        return NGVEnableDirectDriveCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeShowPreGameMessageCommand() -> GameViewCommand {
        return NGVShowPreGameMessageCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeShowPostGameMessageCommand() -> GameViewCommand {
        return NGVShowPostGameMessageCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeShowFailMessageCommand() -> GameViewCommand {
        return NGVShowFailMessageCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    
    
    
    class func NativePlayCommand() -> GameMenuCommand {
        return NGVPlayCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeStopCommand() -> GameMenuCommand {
        return NGVStopCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativePauseCommand() -> GameMenuCommand {
        return NGVPauseCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeResumeCommand() -> GameMenuCommand {
        return NGVResumeCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeMuteCommand() -> GameMenuCommand {
        return NGVMuteCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    
    
    
    class func NativeAddBlockCommand(block: Block) -> BlocklyCommand {
        return NGVAddBlockCommand(gameViewController: StaticContext.MainGameViewController!, block: block)
    }


    
    
    class func NativeMoveForwardCommand() -> GameMapCommand {
        return NGVMoveForwardCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeTurnLeftCommand() -> GameMapCommand {
        return NGVTurnLeftCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeTurnRightCommand() -> GameMapCommand {
        return NGVTurnRightCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeDeliverCommand() -> GameMapCommand {
        return NGVDeliverCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeShowResultCommand() -> GameMapCommand {
        return NGVShowResultCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativePauseAnimationCommand() -> GameMapCommand {
        return NGVPauseAnimationCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
    class func NativeUnpauseAnimationCommand() -> GameMapCommand {
        return NGVUnpauseAnimationCommand(gameViewController: StaticContext.MainGameViewController!)
    }
    
}
