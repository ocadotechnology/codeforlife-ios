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
    
    @IBOutlet weak var blocklyButton: GameViewButton!
    @IBOutlet weak var saveButton: GameViewButton!
    @IBOutlet weak var loadButton: GameViewButton!
    @IBOutlet weak var muteButton: GameViewButton!
    @IBOutlet weak var playButton: GameViewButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var webView: WKWebView? {
        didSet {
            CommandFactory.gameView = webView
        }
    }
    
    var level: Level?
    
    var mute = false {
        didSet {
            muteButton.setTitle(mute ? "Unmute" : "Mute", forState: UIControlState.Normal)
        }
    }
    
    var playing = false {
        didSet {
            
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
    
    var buttonSet = [GameViewButton]()
    
    var handler: GameViewInteractionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupButtonSet()
        self.activityIndicator.hidesWhenStopped = true
        self.containerView.addSubview(self.webView!)
        self.webView?.snp_makeConstraints({ (make) -> Void in
            make.edges.equalTo(self.containerView)
        })
        
        self.activityIndicator.startAnimating()
        
        // Load Level
        if let requestedLevel = self.level {
            GVLoadLevelCommand(level: requestedLevel, webView: webView!).execute {}
        }
    }
    
    private func setupWebView() {
        handler = GameViewInteractionHandler(gameViewController: self)
        var config = WKWebViewConfiguration()
        config.userContentController.addScriptMessageHandler(handler!, name: "handler")
        self.webView = WKWebView(frame: self.containerView.frame, configuration: config)
        self.webView?.navigationDelegate = self
        self.webView?.UIDelegate = self
        self.webView?.scrollView.maximumZoomScale = 1.0
        self.webView?.scrollView.minimumZoomScale = 1.0
        self.webView?.multipleTouchEnabled = false
    }
    
    private func setupButtonSet() {
        currentTab = blocklyButton
        buttonSet.append(blocklyButton)
        buttonSet.append(loadButton)
        buttonSet.append(saveButton)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        webView.evaluateJavaScript(
            "document.getElementById('right').style.marginLeft = '0px';" +
            "document.getElementById('tabs').style.display = 'none';"
            , completionHandler: nil)
        handler!.askForCurrentTab()
        self.activityIndicator.stopAnimating()
    }
    
    @IBAction func blockly() {
        GVBlocklyCommand(gameView: webView!).execute {
            self.currentTab = self.blocklyButton
        }
    }
    
    @IBAction func clear() {
        GVClearCommand(gameView: webView!).execute()
    }
    
    
    @IBAction func play() {
        GVPlayCommand(gameView: webView!).execute()
    }
    
    @IBAction func stop() {
        GVStopCommand(gameView: webView!).execute()
    }
    
    @IBAction func step() {
        GVStepCommand(gameView: webView!).execute()
    }
    
    @IBAction func load() {
        GVLoadCommand(gameView: webView!).execute {
            self.currentTab = self.loadButton
        }
    }
    
    @IBAction func save() {
        GVSaveCommand(gameView: webView!).execute {
            self.currentTab = self.saveButton
        }
    }
    
    @IBAction func help() {
        GVHelpCommand(gameView: webView!).execute()
    }

    @IBAction func muteSound() {
        GVMuteCommand(gameView: webView!).execute {
            self.mute = !self.mute
        }
    }
    
}
