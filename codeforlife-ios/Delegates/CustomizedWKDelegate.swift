//
//  CustomizedWKDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

/*  This delegate is created for the sole purpose to understand the
 *  work process of the WKWebView which was introduced when iOS8 was
 *  released.
 *  WKWebView that is assigned with this delegate will be actively
 *  reporting all the method calls related to view.
 */

/*  decidePolicyForNavigationAction
 *         |
 *         |
 *         v
 *  didStartProvisionalNavigation
 *         |
 *         |
 *         v
 *  decidePolicyForNavigationResponse
 *         |
 *         |
 *         v
 *  didCommitNavigation
 *         |
 *         |
 *         v
 *  didFinishNavigation
 */

import Foundation
import WebKit

class CustomizedWKDelegate: NSObject, WKUIDelegate, WKNavigationDelegate{
    
    var verbal = true           /* echo when a method is call if true */
    
    init(verbal: Bool) {
        super.init()
        self.verbal = verbal
    }
    
    // Enum to handle WKNavigationType printing
    private enum NavigationType: String {
        case LinkActivated = "LinkActiviated"
        case BackForward = "BackForward"
        case FormSubmitted = "FormSubmitted"
        case FormResubmitted = "FormResubmitted"
        case Reload = "Reload"
        case Other = "Other"
        
        var description : String {
            return self.rawValue
        }
        
    }
    
    // Private Helper Function
    // Result will only be printed if VERBAL is true
    private func print(string : String) {
        if verbal {
            println(string)
        }
    }

    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.Allow)
        var type : String?
        switch navigationAction.navigationType {
        case WKNavigationType.LinkActivated:
            type = NavigationType.LinkActivated.description
        case WKNavigationType.BackForward:
            type = NavigationType.BackForward.description
        case WKNavigationType.FormSubmitted:
            type = NavigationType.FormSubmitted.description
        case WKNavigationType.FormResubmitted:
            type = NavigationType.FormResubmitted.description
        case WKNavigationType.Reload:
            type = NavigationType.Reload.description
        case WKNavigationType.Other:
            type = NavigationType.Other.description
        default: type = "Error"
        }
        print("decidePolicyForNavigationAction : \(navigationAction.request.URL!) -- Type: \(type)")
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(WKNavigationResponsePolicy.Allow)
        if let httpResponse = navigationResponse.response as? NSHTTPURLResponse {
            print("decidePolicyForNavigationResponse : \(httpResponse.URL)")
        } else {
            print("decidePolicyForNavigationResponse : Not a HTTPURLResponse")
        }
    }
    
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        print("didCommitNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        print("didFailNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print("didFailProvisionalNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("didFinishNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        print("didReceiveAuthenticationChallenge : \(challenge.description)")
    }
    
    func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation : \(navigation.description)")
    }
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        print("runJavaScriptAlertPanelWithMessage : \(message)")
    }
    
    func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (Bool) -> Void) {
        print("runJavaScriptConfirmPanelWithMessage : \(message)")
    }
    
    func webView(webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: (String!) -> Void) {
        print("runJavaScriptTextInputPanelWithPrompt : \(prompt)")
    }
    
}
