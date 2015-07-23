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

    // Controllers
    weak var gameMapViewController: GameMapViewController?
    weak var blockTableViewController: BlockTableViewController?
    weak var directDriveViewController: DirectDriveViewController?
    weak var gameMenuViewController: GameMenuViewController?
    
    var webView: WKWebView?
    
    weak var requestedLevel: Level?
    weak var level: Level? {
        didSet {
            loadLevel(self.level!)
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blockTableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedContext.MainGameViewController = self
        setupWebView()
        level = requestedLevel
    }
    
    private func loadLevel(level: Level) {
        FetchLevelRequest(self).execute {
            [unowned self] in
            FetchMapRequest(self, self.level?.mapUrl).execute()
            ActionFactory.createAction("PregameMessage").execute()
            ActionFactory.createAction("Clear").execute()
            self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: self.level!.webViewUrl)!))
        }
    }
    
    private func setupWebView() {
        let config = WKWebViewConfiguration()
        let handler = GameViewInteractionHandler(self)
        config.userContentController.addScriptMessageHandler(handler, name: scriptMessageHandlerTitle)
        webView = WKWebView(frame: CGRectNull, configuration: config)
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
    
//    deinit { println("GameViewController is being deallocated") }
    
}
