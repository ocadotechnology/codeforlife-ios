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

class GameViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var muteButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var webView: WKWebView?
    
    var mute = false {
        didSet {
            muteButton.setTitle(mute ? "Unmute" : "Mute", forState: UIControlState.Normal)
        }
    }
    
    var level: Level? {
        didSet {
            if (self.isViewLoaded()) {
                updateUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        self.activityIndicator.hidesWhenStopped = true
        self.containerView.addSubview(self.webView!)
        self.webView?.snp_makeConstraints({ (make) -> Void in
            make.edges.equalTo(self.containerView)
        })
        updateUI()
    }
    
    private func setupWebView() {
        self.webView = WKWebView()
        self.webView?.navigationDelegate = self
        self.webView?.UIDelegate = self
        self.webView?.scrollView.maximumZoomScale = 1.0
        self.webView?.scrollView.minimumZoomScale = 1.0
        self.webView?.multipleTouchEnabled = false
    }
    
    private func updateUI() {
        self.activityIndicator.startAnimating()
        if let requestedLevel = self.level {
            GVLoadLevelCommand(level: requestedLevel, webView: webView!).execute {}
        }
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        removeGameDetailViewTabMenu()
        self.activityIndicator.stopAnimating()
    }
    
    func runJavaScript(script: String) {
        self.webView?.evaluateJavaScript(script) {(data, error) -> Void in
            if error != nil {
                println(error.description)
            }
        }
    }
    
    private func removeGameDetailViewTabMenu(){
        runJavaScript("document.getElementById('tabs').style.display = 'none';")
    }
    
    @IBAction func blockly() {
        GVBlocklyCommand(gameView: webView!).execute {}
    }
    
    @IBAction func clear() {
        GVClearCommand(gameView: webView!).execute {}
    }
    
    
    @IBAction func play() {
        GVPlayCommand(gameView: webView!).execute {}
    }
    
    @IBAction func stop() {
        GVStopCommand(gameView: webView!).execute {}
    }
    
    @IBAction func step() {
        GVStepCommand(gameView: webView!).execute {}
    }
    
    @IBAction func load() {
        GVLoadCommand(gameView: webView!).execute {}
    }
    
    @IBAction func save() {
        GVSaveCommand(gameView: webView!).execute {}
    }
    
    @IBAction func help() {
        GVHelpCommand(gameView: webView!).execute {}
    }
    
    @IBAction func mute(sender: UIButton) {
        GVMuteCommand(gameView: webView!).execute {}
        mute = !mute
    }
    
}
