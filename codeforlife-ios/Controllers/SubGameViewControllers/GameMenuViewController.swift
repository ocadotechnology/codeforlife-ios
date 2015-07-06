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
    
    var delegate: GameMenuViewControllerDelegate = GameMenuViewControllerNativeDelegate()
    
    var gameMenuFrame: CGSize {
        return CGSize(
            width: StaticContext.MainGameViewController!.view.frame.width*(1-StaticContext.MainGameViewController!.webViewPortion) - 2*frameOffset,
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
            StaticContext.MainGameViewController!.view.frame.height + gameMenuFrame.height/2 - menuOffset)
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
            playButton.setTitle(controlMode.text, forState: UIControlState.Normal)
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
    
}
