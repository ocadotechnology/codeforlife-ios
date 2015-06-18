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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var webView: WKWebView? {
        didSet {
            CodeForLifeContext.webView = webView
        }
    }
    
    var level: Int? {
        didSet {
            updateUI()
        }
    }
    
    private func setupWebView() {
        self.webView = WKWebView()
        self.webView!.allowsBackForwardNavigationGestures = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        self.activityIndicator.hidesWhenStopped = true
        self.containerView.addSubview(self.webView!)
        self.containerView.sendSubviewToBack(self.webView!)
        self.webView?.snp_makeConstraints({ (make) -> Void in
            make.edges.equalTo(self.containerView)
        })
        updateUI()
    }
    
    private func updateUI() {
        if let requestedLevel = self.level {
            if let command = CommandFactory.loadLevelCommand(requestedLevel) {
                command.excute() { (level: Level) -> Void in
                    println("Level \(level.number) loaded")
                }
            }
        }
    }
    
}
