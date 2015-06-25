//
//  GameMenuViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class GameMenuViewController: UIViewController {
    
    let blocklyButtonText = "Blockly"
    let pythonButtonText = "Python"
    let muteToUnmuteButtonText = "Unmute"
    let unmuteToMuteButtonText = "Mute"
    
    @IBOutlet weak var muteButton: GameViewButton!
    @IBOutlet weak var playButton: GameViewButton!
    
    enum ControlMode {
        case onPlayControls
        case onPauseControls
        case onStepControls
        case onStopControls
        case onResumeControls
    }
    
    var gameViewController: GameViewController?
    
//    var blocklyEnabled = false {
//        didSet {
//            blocklyButton.setTitle(blocklyEnabled ? blocklyButtonText : pythonButtonText, forState: UIControlState.Normal)
//        }
//    }
    
    var mute = false {
        didSet {
            muteButton.setTitle(mute ? muteToUnmuteButtonText : unmuteToMuteButtonText, forState: UIControlState.Normal)
        }
    }
    
    var controlMode = ControlMode.onStopControls {
        didSet {
            switch controlMode {
            case ControlMode.onPlayControls: onPlayControls()
            case ControlMode.onPauseControls: onPauseControls()
            case ControlMode.onStepControls: onStepControls()
            case ControlMode.onStopControls:  onStopControls()
            case ControlMode.onResumeControls: onResumeControls()
            default: break;
            }
        }
    }

    @IBAction func hideMenu() {
        gameViewController!.toggleMenu()
    }
    
    @IBAction func clear() {
        GameViewCommandFactory.ClearCommand().execute()
        
    }
    
    @IBAction func play() {
        GameViewCommandFactory.PlayCommand().execute()
        
    }
    
    @IBAction func help() {
        GameViewCommandFactory.HelpCommand().execute()
        
    }
    
    @IBAction func muteSound() {
        GameViewCommandFactory.MuteCommand().execute()
    }
    
    func onPlayControls() {
        playButton.setTitle("Pause", forState: UIControlState.Normal)
    }
    
    func onStepControls() {
        playButton.setTitle("Resume", forState: UIControlState.Normal)
    }
    
    func onStopControls() {
        playButton.setTitle("Play", forState: UIControlState.Normal)
    }
    
    func onPauseControls() {
        playButton.setTitle("Resume", forState: UIControlState.Normal)
    }
    
    func onResumeControls() {
        playButton.setTitle("Pause", forState: UIControlState.Normal)
    }
    
}
