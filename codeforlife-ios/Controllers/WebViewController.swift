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


class WebViewController: UIViewController {
    
    @IBOutlet var containerView: UIView! = nil
    
    var webView: WKWebView? {
        didSet {
            CodeForLifeContext.webView = webView
        }
    }
    
    var wkDelegate = CustomizedWKDelegate(verbal: false)
    
    var uiDelegate: WKUIDelegate {
        return wkDelegate
    }
    var nvDelegate: WKNavigationDelegate {
        return wkDelegate
    }
    
    private func setupWebView() {
        self.webView = WKWebView()
        self.webView!.allowsBackForwardNavigationGestures = true
        self.webView!.navigationDelegate = nvDelegate
        self.webView!.UIDelegate = uiDelegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        self.containerView.addSubview(self.webView!);
        self.webView?.snp_makeConstraints({ (make) -> Void in
            make.edges.equalTo(self.containerView)
        })
        
        // Load Request
        var request = NSURLRequest(URL: kCFLWebsiteURL!)
        webView!.loadRequest(request)
        
    }
    
    @IBAction func didLoadlLevelTouch(sender: UIButton) {
        var command:LoadLevelCommand = CommandFactory.loadLevelCommand(1)!;
        command.excute() { (level: Level) -> Void in
             println("Level \(level.number) loaded")
        }
    }
    
}
