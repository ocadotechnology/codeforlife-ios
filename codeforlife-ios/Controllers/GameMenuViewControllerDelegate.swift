//
//  GameMenuViewControllerDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

protocol GameMenuViewControllerDelegate {
    
    func play()
    func help()
    func stop()
    func step()
    func muteSound()
    
}

class GameMenuViewControllerWebViewDelegate: GameMenuViewControllerDelegate {
    
    func play() {
        CommandFactory.WebViewPlayCommand().execute()
    }
    
    func stop() {
        
    }
    
    func step() {
        
    }
    
    func help() {
        CommandFactory.WebViewHelpCommand().execute()
    }
    
    func muteSound() {
        CommandFactory.WebViewMuteCommand().execute()
    }
    
}

class GameMenuViewControllerNativeDelegate: GameMenuViewControllerDelegate {
    
    weak var controller: MessageViewController?
    weak var gameMenuViewController: GameMenuViewController?
    
    func play() {
        switch gameMenuViewController!.controlMode {
        case .onPlayControls: // Going to Pause
            gameMenuViewController?.controlMode = .onPauseControls
            SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.runAnimation = false
            
        case .onStopControls: // Going to Play
            gameMenuViewController?.controlMode = .onPlayControls
            CommandFactory.NativePlayCommand().execute {
                gameMenuViewController?.controlMode = .onStopControls
            }
            
        case .onPauseControls: // Going to Resume
            gameMenuViewController?.controlMode = .onResumeControls
            SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.runAnimation = true
            
        case .onResumeControls: // Going to Pause
            gameMenuViewController?.controlMode = .onPauseControls
            SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.runAnimation = false
            
        case .onStepControls: break
        }
    }
    
    func stop() {
        SharedContext.MainGameViewController?.gameMapViewController?.map?.player.removeAllActions()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.resetMap()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.player.resetPosition()
        SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.resetVariables()
        CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStopControls).execute()
    }
    
    func step() {
    }
    
    func help() {
        if let controller = self.controller {
//            controller.closeMenu()
            self.controller = nil
        } else {
            CommandFactory.NativeShowHelpCommand().execute()
        }
    }
    
    func muteSound() {
        CommandFactory.NativeMuteCommand().execute()
    }
    
    deinit { println("GameMenuViewControllerDelegate is being deallocated") }
    
}