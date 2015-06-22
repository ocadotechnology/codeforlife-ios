//
//  WebViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 16/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class GameViewController: UIViewController, WKNavigationDelegate, WKUIDelegate{
    
    let blocklyButtonText = "Blockly"
    let pythonButtonText = "Python"
    let muteToUnmuteButtonText = "Unmute"
    let unmuteToMuteButtonText = "Mute"
    let scriptMessageHandlerTitle = "handler"
    
    @IBOutlet weak var blocklyButton: GameViewButton!
    @IBOutlet weak var saveButton: GameViewButton!
    @IBOutlet weak var loadButton: GameViewButton!
    @IBOutlet weak var muteButton: GameViewButton!
    @IBOutlet weak var playButton: GameViewButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    enum ControlMode {
        case onPlayControls
        case onPauseControls
        case onStepControls
        case onStopControls
        case onResumeControls
    }
    
    var webView: WKWebView?
    
    var callBack: (() -> Void)?
    
    var buttonSet = [GameViewButton]()
    
    var handler: GameViewInteractionHandler?
    
    var level: Level?
    
    var cargoController: VehicleController?
    
    var blocklyEnabled = false {
        didSet {
            blocklyButton.setTitle(blocklyEnabled ? blocklyButtonText : pythonButtonText, forState: UIControlState.Normal)
        }
    }
    
    var mute = false {
        didSet {
            muteButton.setTitle(mute ? muteToUnmuteButtonText : unmuteToMuteButtonText, forState: UIControlState.Normal)
        }
    }
    
    var finish = false {
        didSet {
            if finish {
                // TODO: show PostGame Message
            }
        }
    }
    
    var currentTab: GameViewButton? {
        didSet {
            for button in buttonSet {
                button.selected = false;
            }
            currentTab?.selected = true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameViewCommandFactory.gameViewController = self
        setupWebView(self.containerView.frame)
        setupCargoController()
        setupButtonSet()
        self.activityIndicator.hidesWhenStopped = true
        self.containerView.addSubview(self.webView!)
        self.webView?.snp_makeConstraints({ (make) -> Void in
            make.edges.equalTo(self.containerView)
        })
        self.activityIndicator.startAnimating()
        
        // Load Level
        if let requestedLevel = self.level {
            GameViewCommandFactory.LoadLevelCommand(requestedLevel).execute {}
        }
    }
    
    func setupWebView(frame: CGRect) {
        handler = GameViewInteractionHandler(gameViewController: self)
        var config = WKWebViewConfiguration()
        config.userContentController.addScriptMessageHandler(handler!, name: scriptMessageHandlerTitle)
        self.webView = WKWebView(frame: frame, configuration: config)
        self.webView?.navigationDelegate = self
        self.webView?.UIDelegate = self
        self.webView?.scrollView.maximumZoomScale = 1.0
        self.webView?.scrollView.minimumZoomScale = 1.0
        self.webView?.multipleTouchEnabled = false
    }
    
    func setupButtonSet() {
        currentTab = blocklyButton
        buttonSet.append(blocklyButton)
        buttonSet.append(loadButton)
        buttonSet.append(saveButton)
    }
    
    func setupCargoController() {
        self.cargoController = CargoController(gameViewController: self)
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
    
    @IBAction func blockly() {
        GameViewCommandFactory.BlocklyCommand().execute {
            self.currentTab = self.blocklyButton
        }
    }
    
    @IBAction func clear() {
        GameViewCommandFactory.ClearCommand().execute()
    }
    
    @IBAction func play() {
        GameViewCommandFactory.PlayCommand().execute()
    }
    
    @IBAction func stop() {
        GameViewCommandFactory.StopCommand().execute()
    }
    
    @IBAction func step() {
        GameViewCommandFactory.StepCommand().execute()
    }
    
    @IBAction func load() {
        GameViewCommandFactory.LoadCommand().execute {
            self.currentTab = self.loadButton
        }
    }
    
    @IBAction func save() {
        GameViewCommandFactory.SaveCommand().execute {
            self.currentTab = self.saveButton
        }
    }
    
    @IBAction func help() {
        GameViewCommandFactory.HelpCommand().execute()
    }

    @IBAction func muteSound() {
        GameViewCommandFactory.MuteCommand().execute {
            self.mute = !self.mute
        }
    }
    
    @IBAction func cargoMoveForward() {
        self.cargoController!.moveForward()
    }
    
    @IBAction func cargoTurnLeft() {
        self.cargoController!.turnLeft()
    }
    
    @IBAction func cargoTurnRight() {
        self.cargoController!.turnRight()
    }
    
    
    func runJavaScript(javaScript: String, callback: () -> Void = {}) {
        webView!.evaluateJavaScript(javaScript) { ( _, _) in
            callback()
        }
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        webView.evaluateJavaScript(
            "document.getElementById('right').style.marginLeft = '0px';" +
            "document.getElementById('tabs').style.display = 'none';" +
            "document.getElementById('direct_drive').style.display = 'none';"
            , completionHandler: nil)
        if activityIndicator != nil {
            self.activityIndicator.stopAnimating()
        }
        if let callBack = self.callBack {
            callBack()
            self.callBack = nil
        }
        
    }
    
}
