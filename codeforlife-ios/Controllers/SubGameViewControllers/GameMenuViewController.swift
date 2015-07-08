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
    
    var delegate = GameMenuViewControllerNativeDelegate()
    
    var gameMenuFrame: CGSize {
        return CGSize(
            width: StaticContext.MainGameViewController!.view.frame.width*(1-StaticContext.MainGameViewController!.webViewPortion) - 2*frameOffset,
            height: frameHeight)
    }
    
    var showPosition : CGPoint {
        return CGPointMake(
            self.view.center.x,
            self.view.center.y - frameHeight + menuOffset)
    }
    
    var hidePosition : CGPoint {
        return CGPointMake(
            self.view.center.x,
            self.view.center.y + frameHeight - menuOffset)
    }
    
    var mute = false {
        didSet {
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
                self.view.center = self.menuOpen ? self.showPosition : self.hidePosition
            }
        }
    }
    
    @IBOutlet weak var muteButton: GameViewButton!
    @IBOutlet weak var playButton: GameViewButton!
    @IBOutlet weak var clearButton: GameViewButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.center = hidePosition
    }
    
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
    
}
