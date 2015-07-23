//
//  ActionFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 22/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import WebKit

class ActionFactory {
    
    static func createAction(action: String) -> Action {
        switch action {
            case "WebViewLoadLevel":
                return WebViewLoadLevelAction()
            case "Help":
                return GameMenuHelpAction()
            case "Clear":
                return GameMenuClearAction()
            case "DisableDirectDrive":
                return NGVDisableDirectDriveAction()
            case "EnableDirectDrive":
                return NGVEnableDirectDriveAction()
            case "PregameMessage":
                return NGVShowPreGameMessageAction()
            case "Play":
                return GameMenuPlayAction()
            case "Mute":
                return GameMenuMuteAction()
            case "ResetAnimation":
                return GameMapResetAnimationAction()
            case "ChangeToOnStopControls":
                return GameMenuSwitchControlModeAction(controlMode: GameMenuViewController.ControlMode.onStopControls)
            case "ChangeToOnPlayControls":
                return GameMenuSwitchControlModeAction(controlMode: GameMenuViewController.ControlMode.onPlayControls)
            case "ChangeToOnPauseControls":
                return GameMenuSwitchControlModeAction(controlMode: GameMenuViewController.ControlMode.onPauseControls)
            case "ChangeToOnResumeControls":
                return GameMenuSwitchControlModeAction(controlMode: GameMenuViewController.ControlMode.onResumeControls)
            case "ChangeToOnStepControls":
                return GameMenuSwitchControlModeAction(controlMode: GameMenuViewController.ControlMode.onStepControls)
            case "AddMoveForwardBlock":
                return BlocklyAddBlockAction(block: Forward())
            case "AddTurnLeftBlock":
                return BlocklyAddBlockAction(block: Left())
            case "AddTurnRightBlock":
                return BlocklyAddBlockAction(block: Right())
            case "AddDeliverBlock":
                return BlocklyAddBlockAction(block: Deliver())
            
        default:
            return Action() //Error Action
        }
    }
    
}
