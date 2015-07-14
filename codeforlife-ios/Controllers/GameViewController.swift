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
        "ocargo.game.reset();" +
        "$('#mute_radio').trigger('click');"

    // Controllers
    weak var gameMapViewController: GameMapViewController?
    weak var blockTableViewController: BlockTableViewController?
    weak var directDriveViewController: DirectDriveViewController?
    weak var gameMenuViewController: GameMenuViewController?
    
    var webView: WKWebView?
    var callBack: (() -> Void)?
    
    weak var requestedLevel: Level?
    weak var level: Level? {
        didSet {
            loadLevel(self.level!)
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var gameMenuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedContext.MainGameViewController = self
        setupWebView()
        level = requestedLevel
    }
    
    func loadLevel(level: Level) {
        FetchLevelAction(self).execute {
            self.WebViewFetchLevelPostAction()
            self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: self.level!.webViewUrl)!))
        }
    }
    
    private func WebViewFetchLevelPostAction() {
        FetchMapAction(self, level?.mapUrl).execute()
        CommandFactory.NativeShowPreGameMessageCommand().execute()
        CommandFactory.NativeClearCommand().execute()
    }
    
    private func NativeFetchLevelPostAction() {
        FetchMapAction(self, level?.mapUrl).execute()
        CommandFactory.NativeShowPreGameMessageCommand().execute()
        CommandFactory.NativeClearCommand().execute()
    }
    
    
    func setupWebView() {
        var config = WKWebViewConfiguration()
        var handler = GameViewInteractionHandler()
        handler.gameViewController = self
        config.userContentController.addScriptMessageHandler(handler, name: scriptMessageHandlerTitle)
        webView = WKWebView(frame: CGRect(origin: CGPointMake(view.frame.width - 350,0), size: CGSize(width: 350, height: 300))
            , configuration: config)
        webView?.navigationDelegate = self
        webView?.UIDelegate = self
        view.addSubview(webView!)
        activityIndicator?.startAnimating()
    }
    
    func runJavaScript(javaScript: String, callback: () -> Void = {}) {
        webView?.evaluateJavaScript(javaScript) { ( _, _) in
            callback()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "GameMenuViewController" :
                self.gameMenuViewController = segue.destinationViewController as? GameMenuViewController
            case "BlockTableViewController" :
                self.blockTableViewController = segue.destinationViewController as? BlockTableViewController
            case "DirectDriveViewController" :
                self.directDriveViewController = segue.destinationViewController as? DirectDriveViewController
            case "GameMapViewController" :
                self.gameMapViewController = segue.destinationViewController as? GameMapViewController
            default: break
            }
        }
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        webView.evaluateJavaScript(webViewPreloadScript, completionHandler: nil)
            self.activityIndicator?.stopAnimating()
        self.callBack?()
        self.callBack = nil
    }
    
    deinit { println("GameViewController is being deallocated") }

    
}
