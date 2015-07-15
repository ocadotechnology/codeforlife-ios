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
    let buttonCount: CGFloat = 8
    let animationDuration: NSTimeInterval = 0.5
    
    enum ControlMode: String {
        case onPlayControls = "Play"
        case onPauseControls = "Pause"
        case onStepControls = "Step"
        case onStopControls = "Stop"
        case onResumeControls = "Resume"
        
        var text : String {
            switch self {
            case .onPlayControls:   return "Pause"
            case .onPauseControls:  return "Resume"
            case .onStepControls:   return "Resume"
            case .onStopControls:   return "Play"
            case .onResumeControls: return "Pause"
            }
        }
        
        var description : String {
            return self.rawValue
        }
    }
    
    /// ControlMode only decides the UI update of the buttons,
    /// and has no direct connection to any actual action to perform
    var controlMode = ControlMode.onStopControls {
        didSet {
            println("switched to \(controlMode.description)")
            playButton.setTitle(controlMode.text, forState: UIControlState.Normal)
            switch controlMode {
            case .onPlayControls:
                clearButton.enabled = false
                gameViewController.blockTableViewController?.editable = false
            case .onStopControls:
                clearButton.enabled = true
                gameViewController.blockTableViewController?.editable = true
            case .onPauseControls: break
            case .onResumeControls: break
            case .onStepControls: break
            }
        }
    }
    
    var delegate = GameMenuViewControllerNativeDelegate()
    
    var mute = false {
        didSet {
            muteButton.setTitle(mute ? muteToUnmuteButtonText : unmuteToMuteButtonText, forState: UIControlState.Normal)
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
        UIView.animateWithDuration(animationDuration) {
            [unowned self] in
            let menuMovement = (self.buttonHeight + self.buttonSpace) * (self.buttonCount - 1)
            self.gameViewController.gameMenuView.center.y += self.gameViewController.gameMenuView.center.y > self.gameViewController.view.frame.height ? -menuMovement : menuMovement
        }
    }

    @IBAction func clear() {
        delegate.clear()
    }
    
    @IBAction func play() {
        delegate.play()
    }
    
    @IBAction func stop() {
        delegate.stop()
    }
    
    @IBAction func step() {
        delegate.step()
    }
    
    @IBAction func help() {
        delegate.help()
    }
    
    @IBAction func muteSound() {
        delegate.muteSound()
    }
    
    deinit { println("GameMenuViewController is being deallocated") }
    
}
