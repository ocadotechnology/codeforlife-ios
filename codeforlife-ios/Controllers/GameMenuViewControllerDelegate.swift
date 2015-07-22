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
    func clear()
    func muteSound()
    
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
        SharedContext.MainGameViewController?.blockTableViewController?.resetHighlightCellVariables()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.van.reset()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.resetMap()
        SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.resetVariables()
        CommandFactory.NativeSwitchControlModeCommand(GameMenuViewController.ControlMode.onStopControls).execute()
    }
    
    func clear() {
        CommandFactory.NativeClearCommand().execute()
    }
    
    func step() {
    }
    
    func help() {
        CommandFactory.HelpCommand().execute()
    }
    
    func muteSound() {
        CommandFactory.NativeMuteCommand().execute()
    }
    
//    deinit { println("GameMenuViewControllerDelegate is being deallocated") }
    
}