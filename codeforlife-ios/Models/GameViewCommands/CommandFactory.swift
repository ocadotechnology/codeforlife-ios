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
    
    
    /***********
     * WebView *
     ***********/
    class func WebViewLoadLevelCommand(level: Level) -> GVLoadLevelCommand {
        return GVLoadLevelCommand(level: level, gameViewController: gameViewController!)
    }

    
    /*********************
    * Game Menu Controls *
    **********************/
    class func HelpCommand() -> GameViewCommand {
        return GameMenuNativeHelpCommand(gameViewController: gameViewController!)
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

    
    
    class func NativeShowResultCommand() -> GameMapCommand {
        return NGVShowResultCommand(gameViewController: gameViewController!)
    }
    
    class func NativeResetAnimationCommand() -> GameMapCommand {
        return NGVResetAnimationCommand(gameViewController: gameViewController!)
    }
    
}
