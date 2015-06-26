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
    
    let gameMenuFrame = CGSize(width: 150, height: 300)
    let offset = 40 as CGFloat
    
    @IBOutlet weak var muteButton: GameViewButton!
    @IBOutlet weak var playButton: GameViewButton!
    
    enum ControlMode {
        case onPlayControls
        case onPauseControls
        case onStepControls
        case onStopControls
        case onResumeControls
    }
    
    var showPosition : CGPoint {
        return CGPointMake(
            self.hidePosition.x,
            self.hidePosition.y - gameMenuFrame.height + offset + 10)
    }
    
    var hidePosition : CGPoint {
        return CGPointMake(
            self.gameMenuFrame.width/2,
            self.gameViewController!.view.frame.height + gameMenuFrame.height/2 - offset)
    }
    
    var frame: CGRect {
        return  CGRect(origin: CGPointMake(0, 0), size: gameMenuFrame)
    }
    
    var gameViewController: GameViewController?
    
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
    
    var menuOpen = false {
        didSet {
            UIView.animateWithDuration(0.5) {
                self.view.center = self.menuOpen ? self.showPosition : self.hidePosition
            }
        }
    }

    @IBAction func toggleMenu() {
        menuOpen = !menuOpen
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
