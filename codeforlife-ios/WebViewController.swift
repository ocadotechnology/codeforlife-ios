//
//  WebViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 16/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet var containerView: UIView! = nil
    
    var webView: WKWebView?
    
    var url = NSURL(string:"http://google.com")!
    
    override func loadView() {
        super.loadView()
        setupWebView()
        self.view = self.webView
    }
    
    /* Set up webView
     * This function should be called right after super.loadView() to
     * set up the webView as soon as possible
     */
    private func setupWebView() {
        self.webView = WKWebView()
        self.webView!.allowsBackForwardNavigationGestures = true
        self.webView!.navigationDelegate = self
        self.webView!.UIDelegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Request
        var request = NSURLRequest(URL: url)
        webView!.loadRequest(request)
        
    }
    
    /*********************/
    /* WKWebViewDelegate */
    /*********************/
    
    
}
