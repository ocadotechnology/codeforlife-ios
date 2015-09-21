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

public class GameViewController: UIViewController, WKNavigationDelegate {
    
    let scriptMessageHandlerTitle = "handler"
    let webViewPreloadScript = "$('#mute_radio').trigger('click');"
    
    struct SegueIdentifier {
        static let GameMenuViewController = "GameMenuViewController"
        static let BlocklyViewController = "BlockTableViewController"
        static let GameMapViewController = "GameMapViewController"
    }

    public weak var gameMapViewController: GameMapViewController? {
        didSet {
            self.gameMapViewController?.gvcDelegate = self.gameViewInteractionHandler.gvcDelegate
            self.gvcDelegate.setGameMapViewController(self.gameMapViewController)
        }
    }
    
    public weak var blockTableViewController: BlockTableViewController? {
        didSet {
            self.blockTableViewController?.gvcDelegate = self.gameViewInteractionHandler.gvcDelegate
            self.gvcDelegate.setBlocklyViewController(blockTableViewController)
        }
    }
    
    public weak var gameMenuViewController: GameMenuViewController? {
        didSet {
            self.gameMenuViewController?.gvcDelegate = self.gameViewInteractionHandler.gvcDelegate
            self.gvcDelegate.setGameMenuViewController(self.gameMenuViewController)
        }
    }

    public let gameViewInteractionHandler: GameViewInteractionHandler
    public let gvcDelegate: GameViewControllerDelegate
    public let webView: WKWebView
    
    public var level: Level?
    public var levelUrl = "" {
        didSet {
            if isViewLoaded() {
                loadLevel(levelUrl)
            }
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blockTableView: UIView!
    
    init(_ coder: NSCoder? = nil) {
        gvcDelegate = GameViewControllerDelegate()
        gameViewInteractionHandler = GameViewInteractionHandler(gameViewControllerDelegate: gvcDelegate)
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
        gvcDelegate.gameViewController = self
        webView.navigationDelegate = self
    }
    
    required public convenience init(coder: NSCoder) {
        self.init(coder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator?.accessibilityIdentifier = "Spinner"
        activityIndicator?.startAnimating()
    }
    
    override public func viewDidAppear(animated: Bool) {
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
            self.activityIndicator?.startAnimating()
            gameViewInteractionHandler.gvcDelegate.enableMultimediaButtons(false, completion: nil)
        }
    }
    
    func runJavaScript(javaScript: String, callback: (() -> Void)? = nil) {
        webView.evaluateJavaScript(javaScript) { ( _, _) in callback?() }
    }
    
    public func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        webView.evaluateJavaScript(webViewPreloadScript, completionHandler: nil)
        self.activityIndicator?.stopAnimating()
        self.gameViewInteractionHandler.gvcDelegate.enableMultimediaButtons(true, completion: nil)
    }
    
    public func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        var credential = NSURLCredential(user: DevUsername, password: DevPassword, persistence: NSURLCredentialPersistence.Permanent)
        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
    }
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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
