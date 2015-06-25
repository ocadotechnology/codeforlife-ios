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
    
    let directDriveFrame = CGSize(width: 245, height: 165)
    
    let gameMenuFrame = CGSize(width: 80, height: 500)
    
    let webViewFrame = CGSize(width: 0, height: 0)
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var gameMenuViewController: GameMenuViewController?
    
    var directDriveViewController: DirectDriveViewController?
    
    var blockTableViewController: BlockTableViewController?
    
    var webView: WKWebView?
    
    var callBack: (() -> Void)?
    
    var handler = GameViewInteractionHandler()
    
    var level: Level?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameViewCommandFactory.gameViewController = self
        handler.gameViewController = self
        setupWebView()
        setupBlockly()
        setupMenu()
        setupDirectDrive()
        
        // Load Level
        if let requestedLevel = self.level {
            GameViewCommandFactory.LoadLevelCommand(requestedLevel).execute {}
        }
    }
    
    func setupWebView() {
        
        var config = WKWebViewConfiguration()
        config.userContentController.addScriptMessageHandler(handler, name: scriptMessageHandlerTitle)
        
        let frame = CGRect(
            x: view.frame.width/2,
            y: 0,
            width: view.frame.width/2,
            height: view.frame.height)
        
        webView = WKWebView(frame: frame, configuration: config)
        webView!.navigationDelegate = self
        webView!.UIDelegate = self
        println("webView!.frame = \(webView!.frame)")
        println("webView!.bounds = \(webView!.bounds)")
        view.addSubview(webView!)
        view.sendSubviewToBack(webView!)
        activityIndicator.startAnimating()
    }
    
    func setupBlockly() {
        blockTableViewController = storyboard?.instantiateViewControllerWithIdentifier("BlockTableViewController") as? BlockTableViewController
        addChildViewController(blockTableViewController!)
        blockTableViewController!.view.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.width/2,
            height: view.frame.height)
        println("blockly!.frame = \(blockTableViewController!.view.frame)")
        println("blockly!.bounds = \(blockTableViewController!.view.bounds)")
        view.addSubview(blockTableViewController!.view)
        view.sendSubviewToBack(blockTableViewController!.view)
        blockTableViewController!.didMoveToParentViewController(self)
    }
    
    func setupMenu() {
        gameMenuViewController = storyboard?.instantiateViewControllerWithIdentifier("GameMenuViewController") as? GameMenuViewController
        addChildViewController(gameMenuViewController!)
        gameMenuViewController!.view.frame = CGRect(
            x: 5,
            y: view.frame.height - gameMenuFrame.height,
            width: gameMenuFrame.width,
            height: gameMenuFrame.height)
        view.addSubview(gameMenuViewController!.view)
        gameMenuViewController!.didMoveToParentViewController(self)
        gameMenuViewController!.view.hidden = true
        handler.gameMenuViewController = self.gameMenuViewController
    }
    
    func setupDirectDrive() {
        directDriveViewController = storyboard?.instantiateViewControllerWithIdentifier("DirectDriveViewController") as? DirectDriveViewController
        directDriveViewController!.controller = CargoController(gameViewController: self)
        addChildViewController(directDriveViewController!)
        directDriveViewController!.view.frame = CGRect(
            x: view.frame.width - directDriveFrame.width - 5,
            y: view.frame.height - directDriveFrame.height - 5,
            width: directDriveFrame.width,
            height: directDriveFrame.height)
        view.addSubview(directDriveViewController!.view)
        directDriveViewController!.didMoveToParentViewController(self)
    }
    
    @IBAction func toggleMenu() {
        gameMenuViewController!.view.hidden = !gameMenuViewController!.view.hidden
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
