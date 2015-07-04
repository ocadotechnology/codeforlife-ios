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
        println("HI")
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
 
    func clear() {
        
    }
    
    func play() {
    }
    
    func help() {
//        gameViewController!.helpViewController!.message = HelpMessage(
//            context: gameViewController!.level!.hint!,
//            action: gameViewController!.helpViewController!.closeMenu)
//        gameViewController!.helpViewController!.toggleMenu()
    }
    
    func muteSound() {
        
    }
    
}