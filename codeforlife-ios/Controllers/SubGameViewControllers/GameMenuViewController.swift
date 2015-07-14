//
//  GameMenuViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class GameMenuViewController: SubGameViewController {
    
    let blocklyButtonText = "Blockly"
    let pythonButtonText = "Python"
    let muteToUnmuteButtonText = "Unmute"
    let unmuteToMuteButtonText = "Mute"
    let buttonHeight: CGFloat = 35
    let buttonSpace:CGFloat = 10
    let buttonCount: CGFloat = 6
    let animationDuration: NSTimeInterval = 0.5
    
    enum ControlMode {
        case onPlayControls
        case onPauseControls
        case onStepControls
        case onStopControls
        case onResumeControls
        
        var text : String {
            switch self {
            case .onPlayControls:   return "Pause"
            case .onPauseControls:  return "Resume"
            case .onStepControls:   return "Resume"
            case .onStopControls:   return "Play"
            case .onResumeControls: return "Pause"
            }
        }
    }
    
    var delegate = GameMenuViewControllerNativeDelegate()
    
    var mute = false {
        didSet {
            muteButton.setImage(UIImage(named: mute ? "mute" : "unmute"), forState: UIControlState.Normal)
            muteButton.setTitle(mute ? muteToUnmuteButtonText : unmuteToMuteButtonText, forState: UIControlState.Normal)
        }
    }
    
    var controlMode = ControlMode.onStopControls {
        didSet {
            playButton.setTitle(controlMode.text, forState: UIControlState.Normal)
            switch controlMode {
            case .onPlayControls:
                CommandFactory.NativePlayCommand().execute()
            case .onStopControls:
                CommandFactory.NativeStopCommand().execute()
            case .onPauseControls:
                CommandFactory.NativePauseCommand().execute()
            case .onResumeControls:
                CommandFactory.NativeResumeCommand().execute()
            case .onStepControls: break
            }
        }
    }
    
    var menuOpen = false {
        didSet {
            UIView.animateWithDuration(animationDuration) {
                [unowned self] in
                let menuMovement = (self.buttonHeight + self.buttonSpace) * (self.buttonCount - 1)
                self.gameViewController.gameMenuView.center.y += self.menuOpen ? -menuMovement : menuMovement
            }
        }
    }
    
    @IBOutlet weak var muteButton: GameViewButton!
    @IBOutlet weak var playButton: GameViewButton!
    @IBOutlet weak var clearButton: GameViewButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.gameMenuViewController = self
    }
    
    @IBAction func toggleMenu() {
        menuOpen = !menuOpen
    }

    @IBAction func clear() {
        delegate.clear()
    }
    
    @IBAction func play() {
        delegate.play()
    }
    
    @IBAction func help() {
        delegate.help()
    }
    
    @IBAction func muteSound() {
        delegate.muteSound()
    }
    
    deinit {
        println("GameMenuViewController is being deallocated")
    }
    
}
