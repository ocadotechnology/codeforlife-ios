//
//  GameMenuViewControllerDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

protocol GameMenuViewControllerDelegate {
    
    func clear()
    func play()
    func help()
    func stop()
    func step()
    func muteSound()
    
}

class GameMenuViewControllerWebViewDelegate: GameMenuViewControllerDelegate {
    
    func clear() {
        CommandFactory.WebViewClearCommand().execute()
    }
    
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
 
    func clear() {
        CommandFactory.WebViewClearCommand().execute()
        CommandFactory.NativeClearCommand().execute()
    }
    
    func play() {
        switch gameMenuViewController!.controlMode {
        case .onPlayControls: // Going to Pause
            gameMenuViewController?.controlMode = .onPauseControls
            SharedContext.MainGameViewController?.gameMapViewController?.shouldRunAnimation = false
            
        case .onStopControls: // Going to Play
            gameMenuViewController?.controlMode = .onPlayControls
            CommandFactory.NativePlayCommand().execute {
                gameMenuViewController?.controlMode = .onStopControls
            }
            
        case .onPauseControls: // Going to Resume
            gameMenuViewController?.controlMode = .onResumeControls
            SharedContext.MainGameViewController?.gameMapViewController?.shouldRunAnimation = true
            
        case .onResumeControls: // Going to Pause
            gameMenuViewController?.controlMode = .onPauseControls
            SharedContext.MainGameViewController?.gameMapViewController?.shouldRunAnimation = false
            
        case .onStepControls: break
        }
    }
    
    func stop() {

    }
    
    func step() {
    }
    
    func help() {
        if let controller = self.controller {
            controller.closeMenu()
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