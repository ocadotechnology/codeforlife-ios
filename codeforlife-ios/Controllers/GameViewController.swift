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
import AVFoundation

class GameViewController: UIViewController, WKNavigationDelegate {
    
    let scriptMessageHandlerTitle = "handler"
    let webViewPreloadScript = "$('#mute_radio').trigger('click');"

    weak var gameMapViewController: GameMapViewController?
    weak var blockTableViewController: BlockTableViewController?
    weak var directDriveViewController: DirectDriveViewController?
    weak var gameMenuViewController: GameMenuViewController?

    var gameViewInteractionHandler: WKScriptMessageHandler?
    var webView: WKWebView?
    
    var level: Level?
    var levelUrl = "" {
        didSet {
            loadLevel(levelUrl)
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blockTableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedContext.MainGameViewController = self
        gameViewInteractionHandler = GameViewInteractionHandler(self)
        setupWebView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadLevel(levelUrl)
    }
    
    private func loadLevel(levelUrl: String) {
        let levels  = Level.fetchResults().filter({$0.url == levelUrl})
        if levels.count > 0 {
            level = levels[0]
            let map = CDMap.fetchResults().filter({$0.url == self.level!.url})[0].toMap()
            SharedContext.MainGameViewController?.gameMapViewController?.map = map
            ActionFactory.createAction("PregameMessage").execute()
            ActionFactory.createAction("Clear").execute()
            self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: self.level!.webViewUrl)!))
        }
    }
    
    private func setupWebView() {
        let userContentController = WKUserContentController()
        userContentController.addScriptMessageHandler(InteractionHandler(delegate: gameViewInteractionHandler), name: scriptMessageHandlerTitle)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        webView = WKWebView(frame: CGRectZero, configuration: configuration)
        webView?.navigationDelegate = self
        activityIndicator?.startAnimating()
    }
    
    func runJavaScript(javaScript: String, callback: (() -> Void)? = nil) {
        webView?.evaluateJavaScript(javaScript) { ( _, _) in
            callback?()
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
    }
    
    func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        var credential = NSURLCredential(user: "trial", password: "cabbage", persistence: NSURLCredentialPersistence.Permanent)
        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
    }
    
    // Some extra releases need to be done manually due to the retain cycle
    // caused by UserContentController. It is believed that there exists a
    // retain cycle between WKUserContentController and its ScriptMessageHandler
    deinit {
//        println("GameViewController is being deallocated")
        self.webView?.stopLoading()
        self.webView?.configuration.userContentController.removeScriptMessageHandlerForName(scriptMessageHandlerTitle)
        self.webView = nil
    }
    
}
