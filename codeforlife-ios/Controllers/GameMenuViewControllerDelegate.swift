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
            ActionFactory.createAction("Play").execute()
            
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
        ActionFactory.createAction("ChangeToOnStopControls").execute()
    }
    
    func clear() {
        ActionFactory.createAction("Clear").execute()
    }
    
    func step() {
        switch gameMenuViewController!.controlMode {
            
        case .onStopControls:
            gameMenuViewController?.controlMode = .onStepControls
            SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.step = true
            ActionFactory.createAction("Play").execute()
            
        case .onPauseControls:
            gameMenuViewController?.controlMode = .onStepControls
            SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.step = true
            SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.runAnimation = true
            
        default: break
        }
    }
    
    func help() {
        ActionFactory.createAction("Help").execute()
    }
    
    func muteSound() {
        ActionFactory.createAction("Mute").execute()
    }
    
//    deinit { println("GameMenuViewControllerDelegate is being deallocated") }
    
}