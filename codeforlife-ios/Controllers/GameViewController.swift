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
    let webViewFrame = CGSize(width: 0, height: 0)
    let webViewCornerRadius: CGFloat = 10
    let webViewOffset: CGFloat = 10
    
    let webViewPreloadScript =
        "document.getElementById('right').style.marginLeft = '0px';" +
        "document.getElementById('tabs').style.display = 'none';" +
        "document.getElementById('tab_panes').style.display = 'none';" +
        "document.getElementById('consoleSlider').style.display = 'none';" +
        "document.getElementById('paper').style.width = '100%';" +
        "document.getElementById('direct_drive').style.display = 'none';" +
        "ocargo.blocklyControl.reset();" +
        "ocargo.game.reset();"

    // Controllers
    var gameMenuViewController: GameMenuViewController?
    var directDriveViewController: DirectDriveViewController?
    var blockTableViewController: BlockTableViewController?
    var helpViewController: MessageViewController?
    var gameMessageViewController: MessageViewController?
    var postGameMessageViewController: MessageViewController?
    var gameMapViewController: GameMapViewController?
    
    var webView: WKWebView?
    var callBack: (() -> Void)?
    var handler = GameViewInteractionHandler()
    
    var level: Level? {
        didSet {
            if isViewLoaded() {
                loadLevel(self.level!)
            }
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameViewController()
        //setupWebView()
        setupGameMapViewController()
        setupBlocklyTableViewController()
        setupGameMenuViewController()
        setupDirectDriveViewController()
        setupHelpMessageViewController()
        setupGameMessageViewController()
        setupPostGameMessageViewController()
        loadLevel(self.level!)
    }
    
    func setupGameViewController() {
        CommandFactory.gameViewController = self
        handler.gameViewController = self
    }
    
    func setupWebView() {
        var config = WKWebViewConfiguration()
        config.userContentController.addScriptMessageHandler(handler, name: scriptMessageHandlerTitle)
        webView = WKWebView(frame: CGRect(
            x: view.frame.width * (1 - webViewPortion) + webViewOffset,
            y: webViewOffset,
            width: view.frame.width * webViewPortion - 2 * webViewOffset,
            height: view.frame.height - 2 * webViewOffset)
            , configuration: config)
        webView!.navigationDelegate = self
        webView!.layer.cornerRadius = webViewCornerRadius
        webView!.layer.masksToBounds = true
        view.addSubview(webView!)
        view.sendSubviewToBack(webView!)
        activityIndicator?.startAnimating()
    }
    
    func setupGameMapViewController() {
        gameMapViewController = ViewControllerFactory.GameMapViewControllerInstance()
        setupController(gameMapViewController!)
    }
    
    func setupBlocklyTableViewController() {
        blockTableViewController = ViewControllerFactory.BlocklyViewControllerInstance()
        setupController(blockTableViewController!)
    }
    
    func setupGameMenuViewController() {
        gameMenuViewController = ViewControllerFactory.GameMenuViewControllerInstance()
        setupController(gameMenuViewController!)
    }
    
    func setupDirectDriveViewController() {
        directDriveViewController = ViewControllerFactory.DirectDriveViewControllerInstance()
        setupController(directDriveViewController!)
    }
    
    func setupHelpMessageViewController() {
        helpViewController = ViewControllerFactory.MessageViewControllerInstance()
        setupController(helpViewController!)
    }
    
    func setupGameMessageViewController() {
        gameMessageViewController = ViewControllerFactory.MessageViewControllerInstance()
        setupController(gameMessageViewController!)
    }
    
    func setupPostGameMessageViewController() {
        postGameMessageViewController = ViewControllerFactory.MessageViewControllerInstance()
        setupController(postGameMessageViewController!)
    }
    
    func loadLevel(level: Level) {
        FetchLevelAction(self).execute {
            if let controller = self.gameMessageViewController,
                level = self.level {
                controller.message = PreGameMessage(title: "Level \(level.name)", context: level.description!,
                    action: controller.closeMenu)
                self.gameMapViewController?.map = Map(width: 8, height: 8, origin: self.level!.origin!, nodes: self.level!.path, destination: [Node]())
                controller.toggleMenu()
            }
        }
        CommandFactory.LoadLevelCommand(level).execute()
    }
    
    func runJavaScript(javaScript: String, callback: () -> Void = {}) {
        webView?.evaluateJavaScript(javaScript) { ( _, _) in
            callback()
        }
    }

    private func setupController(controller: SubGameViewController) {
        controller.gameViewController = self
        addChildViewController(controller)
        view.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        webView.evaluateJavaScript(webViewPreloadScript, completionHandler: nil)
            self.activityIndicator?.stopAnimating()
        self.callBack?()
        self.callBack = nil
    }
    
}
