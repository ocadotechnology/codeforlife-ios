//
//  GameMenuViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class GameMenuViewController: UIViewController {
    
    let blocklyButtonText = "Blockly"
    let pythonButtonText = "Python"
    let muteToUnmuteButtonText = "Unmute"
    let unmuteToMuteButtonText = "Mute"
    let buttonHeight: CGFloat = 35
    let buttonSpace:CGFloat = 10
    let buttonCount: CGFloat = 8
    let animationDuration: NSTimeInterval = 0.5
    
    static let onPlayControlsImageName = "pause"
    static let onPauseControlsImageName = "play"
    static let onStepControlsImageName = "play"
    static let onStopControlsImageName = "play"
    static let onResumeControlsImageName = "pause"
    static let mutedImageName = "muted"
    static let unmutedImageName = "unmuted"
    
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
            case .onPlayControls:   return GameMenuViewController.onPlayControlsImageName
            case .onPauseControls:  return GameMenuViewController.onPauseControlsImageName
            case .onStepControls:   return GameMenuViewController.onStepControlsImageName
            case .onStopControls:   return GameMenuViewController.onStopControlsImageName
            case .onResumeControls: return GameMenuViewController.onResumeControlsImageName
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
                gvcDelegate?.setBlocklyEditable(false, completion: nil)
                println("changed to onPlayControls")
                
            case .onStepControls:
                clearButton.enabled = false
                playButton.enabled = false
                gvcDelegate?.setBlocklyEditable(false, completion: nil)
                println("changed to onStepControls")
                
            case .onPauseControls:
                playButton.enabled = true
                println("changed to onPauseControls")
                
            case .onResumeControls:
                println("changed to onResumeControls")
                
            case .onStopControls:
                clearButton.enabled = true
                playButton.enabled = true
                gvcDelegate?.setBlocklyEditable(true, completion: nil)
                println("changed to onStopControls")
                
            }
        }
    }
    
    public weak var gvcDelegate: GameViewControllerDelegate?
    
    var muted = false {
        didSet {
            muteButton.setImage(UIImage(named: muted ? GameMenuViewController.mutedImageName : GameMenuViewController.unmutedImageName), forState: UIControlState.Normal)
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
    @IBOutlet weak var stepButton: GameViewButton!
    @IBOutlet weak var stopButton: GameViewButton!
    
    @IBAction func clear() {
        gvcDelegate?.clear(nil)
    }
    
    @IBAction func play() {
        
        switch controlMode {
        case .onPlayControls: // Going to Pause
            controlMode = .onPauseControls
            gvcDelegate?.runAnimation(false, completion: nil)
            
        case .onStopControls: // Going to Play
            controlMode = .onPlayControls
            gvcDelegate?.play(nil)
            
        case .onPauseControls: // Going to Resume
            controlMode = .onResumeControls
            gvcDelegate?.runAnimation(true, completion: nil)
            
        case .onResumeControls: // Going to Pause
            controlMode = .onPauseControls
            gvcDelegate?.runAnimation(false, completion: nil)
            
        case .onStepControls: break
        }
    }
    
    @IBAction func stop() {
        gvcDelegate?.stop(nil)
    }
    
    @IBAction func step() {
        switch controlMode {
            
        case .onStopControls:
            controlMode = .onStepControls
            gvcDelegate?.stepAnimation(true, completion: nil)
            gvcDelegate?.play(nil)
            
        case .onPauseControls:
            controlMode = .onStepControls
            gvcDelegate?.stepAnimation(true, completion: nil)
            gvcDelegate?.runAnimation(true, completion: nil)
            
        default: break
        }
    }
    
    @IBAction func help() {
        gvcDelegate?.help(nil)
    }
    
    @IBAction func mute() {
        muted = !muted
    }
    
//    deinit { println("GameMenuViewController is being deallocated") }
    
}
