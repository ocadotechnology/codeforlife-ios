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
    
    struct SegueIdentifier {
        static let GameMenuViewController = "GameMenuViewController"
        static let BlocklyViewController = "BlockTableViewController"
        static let GameMapViewController = "GameMapViewController"
    }

    weak var gameMapViewController: GameMapViewController? {
        didSet {
            self.gameMapViewController?.gvcDelegate = self.gameViewInteractionHandler.gvcDelegate
            self.gameViewInteractionHandler.gvcDelegate.setGameMapViewController(self.gameMapViewController)
        }
    }
    
    weak var blockTableViewController: BlockTableViewController? {
        didSet {
            self.blockTableViewController?.gvcDelegate = self.gameViewInteractionHandler.gvcDelegate
            self.gameViewInteractionHandler.gvcDelegate.setBlocklyViewController(blockTableViewController)
        }
    }
    
    weak var gameMenuViewController: GameMenuViewController? {
        didSet {
            self.gameMenuViewController?.gvcDelegate = self.gameViewInteractionHandler.gvcDelegate
            self.gameViewInteractionHandler.gvcDelegate.setGameMenuViewController(self.gameMenuViewController)
        }
    }

    let gameViewInteractionHandler: GameViewInteractionHandler
    let webView: WKWebView
    
    var level: Level?
    var levelUrl = "" {
        didSet {
            loadLevel(levelUrl)
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blockTableView: UIView!
    
    init(_ coder: NSCoder? = nil) {
        gameViewInteractionHandler = GameViewInteractionHandler()
        let userContentController = WKUserContentController()
        userContentController.addScriptMessageHandler(InteractionHandler(delegate: gameViewInteractionHandler), name: scriptMessageHandlerTitle)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        webView = WKWebView(frame: CGRectZero, configuration: configuration)
        if let coder = coder {
            super.init(coder: coder)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
        webView.navigationDelegate = self
    }
    
    required convenience init(coder: NSCoder) {
        self.init(coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameViewInteractionHandler.gameViewController = self
        activityIndicator?.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadLevel(levelUrl)
    }
    
    private func loadLevel(levelUrl: String) {
        let levels  = Level.fetchResults().filter({$0.url == levelUrl})
        if levels.count > 0 {
            level = levels[0]
            let mapScene = CDMap.fetchResults().filter({$0.url == self.level!.url})[0].toMap(gameViewInteractionHandler.gvcDelegate)
            gameMapViewController?.mapScene = mapScene
            gameViewInteractionHandler.gvcDelegate.displayPregameMessage(nil)
            gameViewInteractionHandler.gvcDelegate.clear(nil)
            self.webView.loadRequest(NSURLRequest(URL: NSURL(string: self.level!.webViewUrl)!))
        }
    }
    
    func runJavaScript(javaScript: String, callback: (() -> Void)? = nil) {
        webView.evaluateJavaScript(javaScript) { ( _, _) in callback?() }
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        webView.evaluateJavaScript(webViewPreloadScript, completionHandler: nil)
        self.activityIndicator?.stopAnimating()
    }
    
    func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        var credential = NSURLCredential(user: DevUsername, password: DevPassword, persistence: NSURLCredentialPersistence.Permanent)
        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case SegueIdentifier.GameMenuViewController :
                    self.gameMenuViewController = segue.destinationViewController as? GameMenuViewController
                    
                case SegueIdentifier.BlocklyViewController :
                    self.blockTableViewController = segue.destinationViewController as? BlockTableViewController
                    
                case SegueIdentifier.GameMapViewController :
                    self.gameMapViewController = segue.destinationViewController as? GameMapViewController
                
                default: break
            }
        }
    }
    
    // Some extra releases need to be done manually due to the retain cycle
    // caused by UserContentController. It is believed that there exists a
    // retain cycle between WKUserContentController and its ScriptMessageHandler
    deinit {
//        println("GameViewController is being deallocated")
        self.webView.stopLoading()
        self.webView.configuration.userContentController.removeScriptMessageHandlerForName(scriptMessageHandlerTitle)
    }
    
}
