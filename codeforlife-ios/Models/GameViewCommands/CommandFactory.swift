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
    
    static func createCommand(command: String) -> Command {
        switch command {
            case "WebViewLoadLevel":
                return WebViewLoadLevelCommand()
            case "Help":
                return GameMenuHelpCommand()
            case "Clear":
                return GameMenuClearCommand()
            case "DisableDirectDrive":
                return NGVDisableDirectDriveCommand()
            case "EnableDirectDrive":
                return NGVEnableDirectDriveCommand()
            case "PregameMessage":
                return NGVShowPreGameMessageCommand()
            case "Play":
                return GameMenuPlayCommand()
            case "Mute":
                return GameMenuMuteCommand()
            case "ResetAnimation":
                return GameMapResetAnimationCommand()
            case "ChangeToOnStopControls":
                return GameMenuSwitchControlModeCommand(controlMode: GameMenuViewController.ControlMode.onStopControls)
            case "ChangeToOnPlayControls":
                return GameMenuSwitchControlModeCommand(controlMode: GameMenuViewController.ControlMode.onPlayControls)
            case "ChangeToOnPauseControls":
                return GameMenuSwitchControlModeCommand(controlMode: GameMenuViewController.ControlMode.onPauseControls)
            case "ChangeToOnResumeControls":
                return GameMenuSwitchControlModeCommand(controlMode: GameMenuViewController.ControlMode.onResumeControls)
            case "ChangeToOnStepControls":
                return GameMenuSwitchControlModeCommand(controlMode: GameMenuViewController.ControlMode.onStepControls)
            case "AddMoveForwardBlock":
                return BlocklyAddBlockCommand(block: Forward())
            case "AddTurnLeftBlock":
                return BlocklyAddBlockCommand(block: Left())
            case "AddTurnRightBlock":
                return BlocklyAddBlockCommand(block: Right())
            case "AddDeliverBlock":
                return BlocklyAddBlockCommand(block: Deliver())
            
        default:
            return Command() //Error Command
        }
    }
    
}
