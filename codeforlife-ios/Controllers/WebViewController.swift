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

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet var containerView: UIView! = nil
    
    /* WKWebView is introduced in iOS8 to replace UIWebView, this view class is
     * cannot be created in story board. Currently this view class can only be
     * create programmatically.
     */
    var webView: WKWebView? {
        didSet {
            CodeForLifeContext.webView = webView
        }
    }
    
    var url = NSURL(string:"http://localhost:8000/")!
    
    
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
        setupWebView()
        self.containerView.addSubview(self.webView!);
        self.webView?.snp_makeConstraints({ (make) -> Void in
            make.edges.equalTo(self.containerView)
        })
        
        // Load Request
        var request = NSURLRequest(URL: url)
        webView!.loadRequest(request)
        
    }
    
    @IBAction func didLoadlLevelTouch(sender: UIButton) {
        var command:LoadLevelCommand = CommandFactory.loadLevelCommand(1)!;
        command.excute() { (level: Level) -> Void in
             println("Level \(level.number) loaded")
        }
    }
    /*********************/
    /* WKWebViewDelegate */
    /*********************/

//    func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        println("createWebViewWithConfiguration : \(configuration)")
//        return nil
//    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.Allow)
        println("decidePolicyForNavigationAction : \(navigationAction.request.URL!)")
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(WKNavigationResponsePolicy.Allow)
        if let httpResponse = navigationResponse.response as? NSHTTPURLResponse {
            println("decidePolicyForNavigationResponse : \(httpResponse.allHeaderFields)")
        } else {
            println("decidePolicyForNavigationResponse : Not a HTTPURLResponse")
        }
    }
    
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        println("didCommitNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        println("didFailNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        println("didFailProvisionalNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        println("didFinishNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        println("didReceiveAuthenticationChallenge : \(challenge.description)")
    }
    
    func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        println("didReceiveServerRedirectForProvisionalNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        println("didStartProvisionalNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        println("runJavaScriptAlertPanelWithMessage : \(message)")
    }
    
    func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (Bool) -> Void) {
        println("runJavaScriptConfirmPanelWithMessage : \(message)")
    }
    
    func webView(webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: (String!) -> Void) {
        println("runJavaScriptTextInputPanelWithPrompt : \(prompt)")
    }

}
