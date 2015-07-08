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
    var gameMapViewController: GameMapViewController {
        return self.childViewControllers[0] as! GameMapViewController
    }
    var blockTableViewController: BlockTableViewController {
        return self.childViewControllers[1] as! BlockTableViewController
    }
    var directDriveViewController: DirectDriveViewController {
        return self.childViewControllers[2] as! DirectDriveViewController
    }
    var gameMenuViewController: GameMenuViewController {
        return self.childViewControllers[3] as! GameMenuViewController
    }
    
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
    @IBOutlet weak var gameMapView: UIView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameMapViewController.view.frame.size = gameMapView.frame.size
        StaticContext.MainGameViewController = self
        handler.gameViewController = self
        //setupWebView()
        loadLevel(self.level!)
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
    
    func loadLevel(level: Level) {
        FetchLevelAction(self).execute {
            CommandFactory.NativeShowPreGameMessageCommand().execute()
            CommandFactory.NativeClearCommand().execute()
        }
    }
    
    func runJavaScript(javaScript: String, callback: () -> Void = {}) {
        webView?.evaluateJavaScript(javaScript) { ( _, _) in
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
