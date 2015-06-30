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
    let menuOffset: CGFloat = 40            // Offset to always show the head of the menu
    let frameOffset: CGFloat = 10
    let frameHeight: CGFloat = 300
    let animationDuration: NSTimeInterval = 0.5
    
    enum ControlMode {
        case onPlayControls
        case onPauseControls
        case onStepControls
        case onStopControls
        case onResumeControls
    }
    
    private struct PlayButtonText {
        static let onPlayControls = "Pause"
        static let onPauseControls = "Resume"
        static let onStepControls = "Resume"
        static let onStopControls = "Play"
        static let onResumeControls = "Pause"
    }
    
    var gameMenuFrame: CGSize {
        return CGSize(
            width: self.gameViewController!.view.frame.width*(1-self.gameViewController!.webViewPortion) - 2*frameOffset,
            height: frameHeight)
    }
    
    var showPosition : CGPoint {
        return CGPointMake(
            self.hidePosition.x,
            self.hidePosition.y - gameMenuFrame.height + menuOffset + frameOffset)
    }
    
    var hidePosition : CGPoint {
        return CGPointMake(
            self.gameMenuFrame.width/2 + frameOffset,
            self.gameViewController!.view.frame.height + gameMenuFrame.height/2 - menuOffset)
    }
    
    override var frame: CGRect {
        return  CGRect(origin: CGPointMake(0, 0), size: gameMenuFrame)
    }
    
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
            UIView.animateWithDuration(animationDuration) {
                self.view.center = self.menuOpen ? self.showPosition : self.hidePosition
            }
        }
    }
    
    @IBOutlet weak var muteButton: GameViewButton!
    @IBOutlet weak var playButton: GameViewButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.center = hidePosition
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
        playButton.setTitle(PlayButtonText.onPlayControls, forState: UIControlState.Normal)
    }
    
    func onPauseControls() {
        playButton.setTitle(PlayButtonText.onPauseControls, forState: UIControlState.Normal)
    }
    
    func onStepControls() {
        playButton.setTitle(PlayButtonText.onStepControls, forState: UIControlState.Normal)
    }
    
    func onStopControls() {
        playButton.setTitle(PlayButtonText.onStopControls, forState: UIControlState.Normal)
    }
    
    func onResumeControls() {
        playButton.setTitle(PlayButtonText.onResumeControls, forState: UIControlState.Normal)
    }
    
}
