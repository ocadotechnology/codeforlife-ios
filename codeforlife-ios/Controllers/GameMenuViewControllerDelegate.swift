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
        CommandFactory.ClearCommand().execute()
    }
    
    func play() {
        CommandFactory.PlayCommand().execute()
    }
    
    func help() {
        CommandFactory.HelpCommand().execute()
    }
    
    func muteSound() {
        CommandFactory.MuteCommand().execute()
    }
    
}

class GameMenuViewControllerNativeDelegate: GameMenuViewControllerDelegate {
    
    var controller: MessageViewController?
 
    func clear() {
        CommandFactory.NativeClearCommand().execute()
    }
    
    func play() {
        CommandFactory.NativePlayCommand().execute()
    }
    
    func help() {
        if controller != nil {
            controller?.closeMenu()
            controller = nil
        } else {
            CommandFactory.NativeHelpCommand().execute()
        }
    }
    
    func muteSound() {
        
    }
    
}