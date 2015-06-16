//
//  WebViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 16/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var url = NSURL(string:"http://localhost:8000/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize left swipe gesture recognizer
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("webViewSwipe:"))
        leftSwipe.direction = .Left
        
        // Initialize right swipe gesture recognizer
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("webViewSwipe:"))
        rightSwipe.direction = .Right
        
        // Assign Delegate and Gesture Recognizers
        webView.delegate = self
        webView.addGestureRecognizer(leftSwipe)
        webView.addGestureRecognizer(rightSwipe)
        
        // Set up Activity Indicator
        activityIndicator.hidesWhenStopped = true
        
        // Load Request
        var request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
        
    }
    
    // handles webView Swipe
    func webViewSwipe(sender:UISwipeGestureRecognizer) {
        switch sender.direction {
            /*
            * Swipe Left => Go forward
            * Swipe Right => Go back
            */
        case UISwipeGestureRecognizerDirection.Left:
            println("Swipe Left")
            if webView.canGoForward {
                webView.goForward()
            }
        case UISwipeGestureRecognizerDirection.Right:
            println("Swipe Right")
            if webView.canGoBack {
                webView.goBack()
            }
        default: break
        }
    }
    
    
    /*********************/
    /* UIWebViewDelegate */
    /*********************/
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("webViewDidFinishLoad is called")
        activityIndicator.stopAnimating()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        println("webViewDidStartLoad is called")
        activityIndicator.startAnimating()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        println("webView is called:")
        println("-- \(request.URL!)")
        println("-- \(navigationType.rawValue)")
        return true
    }

}
