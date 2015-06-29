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
    var helpViewController: MessageViewController?
    var gameMessageViewController: MessageViewController?
    var postGameMessageViewController: MessageViewController?
    
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
        setupBlocklyTableViewController()
        setupWebView()
        setupGameMenuViewController()
        setupDirectDriveViewController()
        setupHelpMessageViewController()
        setupGameMessageViewController()
        setupPostGameMessageViewController()
        loadLevel(self.level!)
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
        if let controller = blockTableViewController {
            controller.gameViewController = self
            controller.view.frame = controller.frame
            controller.tableView.layer.cornerRadius = 10
            controller.tableView.layer.masksToBounds = true
            addChildViewController(controller)
            view.addSubview(controller.view)
            view.sendSubviewToBack(controller.view)
            controller.didMoveToParentViewController(self)
            
        }
    }
    
    func setupGameMenuViewController() {
        gameMenuViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.GameMenu) as? GameMenuViewController
        if let controller = gameMenuViewController {
            controller.gameViewController = self
            controller.view.frame = controller.frame
            controller.view.center = controller.hidePosition
            addChildViewController(controller)
            view.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
        }
    }
    
    func setupDirectDriveViewController() {
        directDriveViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.DirecDrive) as? DirectDriveViewController
        setupController(directDriveViewController!)
    }
    
    private func setupController(controller: SubGameViewController) {
        controller.gameViewController = self
        controller.view.frame = controller.frame
        addChildViewController(controller)
        view.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
    }
    
    func setupHelpMessageViewController() {
        helpViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.HelpMessage) as? MessageViewController
        setupController(helpViewController!)
    }
    
    func setupGameMessageViewController() {
        gameMessageViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.HelpMessage) as? MessageViewController
        setupController(gameMessageViewController!)
    }
    
    func setupPostGameMessageViewController() {
        postGameMessageViewController = storyboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.HelpMessage) as? MessageViewController
        setupController(postGameMessageViewController!)
    }
    
    func loadLevel(level: Level) {
        GameViewCommandFactory.LoadLevelCommand(level).execute()
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
