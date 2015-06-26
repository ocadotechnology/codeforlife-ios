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
    
    let scriptMessageHandlerTitle = "handler"
    let webViewPortion: CGFloat = 0.7
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Frames
    let directDriveFrame = CGSize(width: 245, height: 165)
    let webViewFrame = CGSize(width: 0, height: 0)
    
    // Controllers
    var gameMenuViewController: GameMenuViewController?
    var directDriveViewController: DirectDriveViewController?
    var blockTableViewController: BlockTableViewController?
    var helpViewController: HelpViewController?
    
    var webView: WKWebView?
    var callBack: (() -> Void)?
    var handler = GameViewInteractionHandler()
    var level: Level?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupBlockly()
        setupWebView()
        setupMenu()
        setupDirectDrive()
        setupHelpView()
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
        gameMenuViewController!.view.frame = gameMenuViewController!.frame
        gameMenuViewController!.view.center = gameMenuViewController!.hidePosition
        addChildViewController(gameMenuViewController!)
        gameMenuViewController!.didMoveToParentViewController(self)
        view.addSubview(gameMenuViewController!.view)
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
    
    func setupHelpView() {
        helpViewController = storyboard?.instantiateViewControllerWithIdentifier("HelpViewController") as? HelpViewController
        helpViewController?.gameViewController = self
        addChildViewController(helpViewController!)
        helpViewController!.view.frame = helpViewController!.frame
        view.addSubview(helpViewController!.view)
        helpViewController!.didMoveToParentViewController(self)
    }
    
    func loadLevel() {
        if let requestedLevel = self.level {
            GameViewCommandFactory.LoadLevelCommand(requestedLevel).execute {}
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
            "document.getElementById('consoleSlider').style.display = 'none';" +
            "document.getElementById('paper').style.width = '100%';" +
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
