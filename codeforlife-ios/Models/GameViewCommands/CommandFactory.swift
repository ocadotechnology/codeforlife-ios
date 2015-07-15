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
    
    class weak var gameViewController : GameViewController? {
        return SharedContext.MainGameViewController
    }
    
    class func WebViewBlocklyCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewBlocklyCommandJavaScript)
    }
    
    class func WebViewClearCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewClearCommandJavaScript)
    }
    
    class func WebViewPlayCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewPlayCommandJavaScript)
    }
    
    class func WebViewStopCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewStopCommandJavaScript)
    }
    
    class func WebViewStepCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewStepCommandJavaScript)
    }
    
    class func WebViewLoadCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewLoadCommandJavaScript)
    }
    
    class func WebViewSaveCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewSaveCommandJavaScript)
    }
    
    class func WebViewHelpCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewHelpCommandJavaScript)
    }
    
    class func WebViewMuteCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: kC4LGameViewMuteCommandJavaScript)
    }
    
    class func WebViewMoveForwardCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: moveForwardJavaScript)
    }
    
    class func WebViewTurnLeftCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: turnLeftJavaScript)
    }
    
    class func WebViewTurnRightCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: turnRightJavaScript)
    }
    
    class func WebViewDeliverCommand() -> GVJavaScriptCommand {
        return GVJavaScriptCommand(gameViewController: gameViewController!, javascript: deliverJavaScript)
    }
    
    class func WebViewLoadLevelCommand(level: Level) -> GVLoadLevelCommand {
        return GVLoadLevelCommand(level: level, gameViewController: gameViewController!)
    }
    
    
    
    
    
    
    class func NativeShowHelpCommand() -> GameViewCommand {
        return NGVShowHelpCommand(gameViewController: gameViewController!)
    }
    
    class func NativeClearCommand() -> GameViewCommand {
        return NGVClearCommand(gameViewController: gameViewController!)
    }
    
    class func NativeDisableDirectDriveCommand() -> GameViewCommand {
        return NGVDisableDirectDriveCommand(gameViewController: gameViewController!)
    }
    
    class func NativeEnableDirectDriveCommand() -> GameViewCommand {
        return NGVEnableDirectDriveCommand(gameViewController: gameViewController!)
    }
    
    class func NativeShowPreGameMessageCommand() -> GameViewCommand {
        return NGVShowPreGameMessageCommand(gameViewController: gameViewController!)
    }
    
    class func NativeShowPostGameMessageCommand() -> GameViewCommand {
        return NGVShowPostGameMessageCommand(gameViewController: gameViewController!)
    }
    
    class func NativeShowFailMessageCommand() -> GameViewCommand {
        return NGVShowFailMessageCommand(gameViewController: gameViewController!)
    }
    
    class func NativePlayCommand() -> GameMenuCommand {
        return NGVPlayCommand(gameViewController: gameViewController!)
    }
    
    class func NativeMuteCommand() -> GameMenuCommand {
        return NGVMuteCommand(gameViewController: gameViewController!)
    }
    
    class func NativeSwitchControlModeCommand(controlMode: GameMenuViewController.ControlMode) -> GameMenuCommand {
        return NGVSwitchControlMode(gameViewController: gameViewController!, controlMode: controlMode)
    }
    
    
    
    
    class func NativeAddBlockCommand(block: Block) -> BlocklyCommand {
        return NGVAddBlockCommand(gameViewController: gameViewController!, block: block)
    }

    
    
    class func NativeMoveForwardCommand() -> GameMapCommand {
        return NGVMoveForwardCommand(gameViewController: gameViewController!)
    }
    
    class func NativeTurnLeftCommand() -> GameMapCommand {
        return NGVTurnLeftCommand(gameViewController: gameViewController!)
    }
    
    class func NativeTurnRightCommand() -> GameMapCommand {
        return NGVTurnRightCommand(gameViewController: gameViewController!)
    }
    
    class func NativeDeliverCommand() -> GameMapCommand {
        return NGVDeliverCommand(gameViewController: gameViewController!)
    }
    
    class func NativeShowResultCommand() -> GameMapCommand {
        return NGVShowResultCommand(gameViewController: gameViewController!)
    }
    
    class func NativePauseAnimationCommand() -> GameMapCommand {
        return NGVPauseAnimationCommand(gameViewController: gameViewController!)
    }
    
    class func NativeUnpauseAnimationCommand() -> GameMapCommand {
        return NGVUnpauseAnimationCommand(gameViewController: gameViewController!)
    }
    
    class func NativeAddAnimationCommand(animation: Animation) -> GameMapCommand {
        return NGVAddAnimationCommand(gameViewController!, animation)
    }
    
    class func NativeResetAnimationCommand() -> GameMapCommand {
        return NGVResetAnimationCommand(gameViewController: gameViewController!)
    }
    
}
