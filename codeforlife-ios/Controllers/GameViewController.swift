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
        "document.getElementById('direct_drive').style.display = 'none';"
    
    private struct StoryBoardIdentifier {
        static let GameMenu = "GameMenuViewController"
        static let DirecDrive = "DirectDriveViewController"
        static let Blockly = "BlockTableViewController"
        static let HelpMessage = "HelpMessageViewController"
    }
    
    // Controllers
    var gameMenuViewController: GameMenuViewController?
    var directDriveViewController: DirectDriveViewController?
    var blockTableViewController: BlockTableViewController?
    var helpViewController: HelpMessageViewController?
    var gameMessageViewController: HelpMessageViewController?
    
    var webView: WKWebView?
    var callBack: (() -> Void)?
    var handler = GameViewInteractionHandler()
    var level: Level?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameViewController()
        setupBlocklyTableViewController()
        setupWebView()
        setupGameMenuViewController()
        setupDirectDriveViewController()
        setupHelpMessageViewController()
        setupGameMessageViewController()
        loadLevel()
    }
    
    func setupGameViewController() {
        GameViewCommandFactory.gameViewController = self
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
        webView!.UIDelegate = self
        webView!.layer.cornerRadius = webViewCornerRadius
        webView!.layer.masksToBounds = true
        view.addSubview(webView!)
        view.sendSubviewToBack(webView!)
        activityIndicator?.startAnimating()
    }
    
    func setupBlocklyTableViewController() {
        blockTableViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.Blockly) as? BlockTableViewController
        blockTableViewController!.gameViewController = self
        blockTableViewController!.view.frame = blockTableViewController!.frame
        blockTableViewController!.tableView.layer.cornerRadius = 10
        blockTableViewController!.tableView.layer.masksToBounds = true
        addChildViewController(blockTableViewController!)
        view.addSubview(blockTableViewController!.view)
        view.sendSubviewToBack(blockTableViewController!.view)
        blockTableViewController!.didMoveToParentViewController(self)
        handler.blockTableViewController = self.blockTableViewController
    }
    
    func setupGameMenuViewController() {
        gameMenuViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.GameMenu) as? GameMenuViewController
        gameMenuViewController!.gameViewController = self
        gameMenuViewController!.view.frame = gameMenuViewController!.frame
        gameMenuViewController!.view.center = gameMenuViewController!.hidePosition
        addChildViewController(gameMenuViewController!)
        view.addSubview(gameMenuViewController!.view)
        gameMenuViewController!.didMoveToParentViewController(self)
        handler.gameMenuViewController = self.gameMenuViewController
    }
    
    func setupDirectDriveViewController() {
        directDriveViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.DirecDrive) as? DirectDriveViewController
        directDriveViewController!.gameViewController = self
        directDriveViewController!.view.frame = directDriveViewController!.frame
        addChildViewController(directDriveViewController!)
        view.addSubview(directDriveViewController!.view)
        directDriveViewController!.didMoveToParentViewController(self)
        handler.directDriveViewController = self.directDriveViewController
    }
    
    func setupHelpMessageViewController() {
        helpViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.HelpMessage) as? HelpMessageViewController
        helpViewController!.gameViewController = self
        helpViewController!.view.frame = helpViewController!.frame
        addChildViewController(helpViewController!)
        view.addSubview(helpViewController!.view)
        helpViewController!.didMoveToParentViewController(self)
    }
    
    func setupGameMessageViewController() {
        gameMessageViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.HelpMessage) as? HelpMessageViewController
        gameMessageViewController!.gameViewController = self
        gameMessageViewController!.view.frame = gameMessageViewController!.frame
        addChildViewController(gameMessageViewController!)
        view.addSubview(gameMessageViewController!.view)
        gameMessageViewController!.didMoveToParentViewController(self)
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
        webView.evaluateJavaScript(webViewPreloadScript, completionHandler: nil)
            self.activityIndicator?.stopAnimating()
        self.callBack?()
        self.callBack = nil
    }
    
}
