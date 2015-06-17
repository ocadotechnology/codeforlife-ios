//
//  ViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 16/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var gameWebView: UIWebView!
    
    @IBAction func back(sender: AnyObject){
        
    }
    
    @IBAction func forward(sender: AnyObject){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "https://www.codeforlife.education/rapidrouter/1/")
        let requestObj = NSURLRequest(URL: url!)
        gameWebView.loadRequest(requestObj)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

