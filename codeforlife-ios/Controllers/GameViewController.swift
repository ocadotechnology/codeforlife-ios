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
    let webViewPortion: CGFloat = 0.7
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var menuButton: GameViewButton!
    
    // Frames
    let directDriveFrame = CGSize(width: 245, height: 165)
    let gameMenuFrame = CGSize(width: 80, height: 300)
    let webViewFrame = CGSize(width: 0, height: 0)
    
    // Controllers
    var gameMenuViewController: GameMenuViewController?
    var directDriveViewController: DirectDriveViewController?
    var blockTableViewController: BlockTableViewController?
    
    var webView: WKWebView?
    var callBack: (() -> Void)?
    var handler = GameViewInteractionHandler()
    var level: Level?
    var menuOpen = false {
        didSet {
            showMenu(menuOpen)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupWebView()
        setupBlockly()
        setupMenu()
        setupDirectDrive()
        loadLevel()
    }
    
    func setupControllers() {
        GameViewCommandFactory.gameViewController = self
        handler.gameViewController = self
    }
    
    func setupWebView() {
        var config = WKWebViewConfiguration()
        config.userContentController.addScriptMessageHandler(handler, name: scriptMessageHandlerTitle)
        webView = WKWebView(frame: CGRect(
            x: view.frame.width * (1 - webViewPortion),
            y: 0,
            width: view.frame.width * webViewPortion,
            height: view.frame.height)
            , configuration: config)
        webView!.navigationDelegate = self
        webView!.UIDelegate = self
        view.addSubview(webView!)
        view.sendSubviewToBack(webView!)
        if let activitIndicator = self.activityIndicator {
            activityIndicator.startAnimating()
        }
    }
    
    func setupBlockly() {
        blockTableViewController = storyboard?.instantiateViewControllerWithIdentifier("BlockTableViewController") as? BlockTableViewController
        addChildViewController(blockTableViewController!)
        blockTableViewController!.view.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.width*(1-webViewPortion),
            height: view.frame.height)
        view.addSubview(blockTableViewController!.view)
        view.sendSubviewToBack(blockTableViewController!.view)
        blockTableViewController!.didMoveToParentViewController(self)
        handler.blockTableViewController = self.blockTableViewController
    }
    
    func setupMenu() {
        gameMenuViewController = storyboard?.instantiateViewControllerWithIdentifier("GameMenuViewController") as? GameMenuViewController
        gameMenuViewController!.gameViewController = self
        addChildViewController(gameMenuViewController!)
        gameMenuViewController!.view.frame = CGRect(
            x: 5,
            y: view.frame.height - gameMenuFrame.height,
            width: gameMenuFrame.width,
            height: gameMenuFrame.height)
        view.addSubview(gameMenuViewController!.view)
        gameMenuViewController!.didMoveToParentViewController(self)
        gameMenuViewController!.view.center = CGPointMake(
            gameMenuViewController!.view.center.x,
            gameMenuViewController!.view.center.y + gameMenuFrame.height)
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
        handler.directDriveViewController = self.directDriveViewController
    }
    
    func loadLevel() {
        if let requestedLevel = self.level {
            GameViewCommandFactory.LoadLevelCommand(requestedLevel).execute {}
        }
    }
    
    @IBAction func toggleMenu() {
        menuOpen = !menuOpen
    }
    
    func showMenu(open: Bool) {
        let c = open ? (1 as CGFloat) : (-1 as CGFloat)
        UIView.animateWithDuration(1.0) {
            let newCenter = CGPointMake(
                self.menuButton.center.x,
                self.menuButton.center.y - c*self.gameMenuFrame.height)
            self.menuButton.center = newCenter
            
            var view = self.gameMenuViewController!.view
            let newCenter2 = CGPointMake(
                view.center.x,
                view.center.y - c*self.gameMenuFrame.height)
            view.center = newCenter2
        }
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
            "document.getElementById('tab_panes').style.display = 'none';" +
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
