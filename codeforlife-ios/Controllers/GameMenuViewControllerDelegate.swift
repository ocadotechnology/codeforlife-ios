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
    func muteSound()
    
}

class GameMenuViewControllerWebViewDelegate: GameMenuViewControllerDelegate {
    
    func clear() {
        CommandFactory.WebViewClearCommand().execute()
    }
    
    func play() {
        CommandFactory.WebViewPlayCommand().execute()
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
        CommandFactory.WebViewPlayCommand().execute()
        switch gameMenuViewController!.controlMode {
        case .onPlayControls:
            gameMenuViewController?.controlMode = .onPauseControls
        case .onStopControls:
            gameMenuViewController?.controlMode = .onPlayControls
        case .onPauseControls:
            gameMenuViewController?.controlMode = .onResumeControls
        case .onResumeControls:
            gameMenuViewController?.controlMode = .onPauseControls
        case .onStepControls: break
        }
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
    
    deinit {
        println("GameMenuViewControllerDelegate is being deallocated")
    }
    
}