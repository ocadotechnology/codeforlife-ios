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
        
        var imageName: String {
            switch self {
            case .onPlayControls:   return "pause"
            case .onPauseControls:  return "resume"
            case .onStepControls:   return "resume"
            case .onStopControls:   return "play"
            case .onResumeControls: return "pause"
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
            playButton.setTitle(controlMode.text, forState: UIControlState.Normal)
            playButton.setImage(UIImage(named: controlMode.imageName), forState: UIControlState.Normal)
            switch controlMode {
            case .onPlayControls:
                clearButton.enabled = false
                gameViewController.blockTableViewController?.recognizer?.editable = false
                gameViewController.directDriveViewController?.disableDirectDrive()
            case .onStopControls:
                clearButton.enabled = true
                gameViewController.blockTableViewController?.recognizer?.editable = true
                gameViewController.directDriveViewController?.enableDirectDrive()
            case .onPauseControls: break
            case .onResumeControls: break
            case .onStepControls: break
            }
        }
    }
    
    var delegate = GameMenuViewControllerNativeDelegate()
    
    var muted = false {
        didSet {
            muteButton.setImage(UIImage(named: muted ? "muted" : "unmuted"), forState: UIControlState.Normal)
            if muted {
                // TODO: mute sound
            } else {
                // TODO: Unmute sound
            }
        }
    }
    
    @IBOutlet weak var clearButton: GameViewButton!
    @IBOutlet weak var muteButton: GameViewButton!
    @IBOutlet weak var playButton: GameViewButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.gameMenuViewController = self
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
    
    @IBAction func mute() {
        muted = !muted
    }
    
//    deinit { println("GameMenuViewController is being deallocated") }
    
}
