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
    
    @IBAction func didPressClear(sender: AnyObject){
        self.clearScreen()
    }
    
    @IBAction func didPressPlay(sender: AnyObject){
        self.play()
    }
    
    @IBAction func didPressStop(sender: AnyObject){
        self.stop()
    }
    
    @IBAction func didPressStepOver(sender: AnyObject){
        self.stepOver()
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
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //remove non-native clear button
        self.removeTabMenu()
    }
    
    func clearScreen(){
        gameWebView.stringByEvaluatingJavaScriptFromString("ocargo.blocklyControl.reset();");
        gameWebView.stringByEvaluatingJavaScriptFromString("ocargo.game.reset();");
//        gameWebView.stringByEvaluatingJavaScriptFromString("$('#clear_radio').trigger('click');")
    }
    
    func play(){
        gameWebView.stringByEvaluatingJavaScriptFromString("$('#play_radio').trigger('click');")
    }
    
    func stop(){
        gameWebView.stringByEvaluatingJavaScriptFromString("$('#stop_radio').trigger('click');")
    }
    
    func stepOver(){
        gameWebView.stringByEvaluatingJavaScriptFromString("$('#step_radio').trigger('click');")
    }
    
    func removeTabMenu(){
        gameWebView.stringByEvaluatingJavaScriptFromString("var divsToHide = document.getElementsByClassName('tab');" +
                                                           "for(var i = 0; i < divsToHide.length; i++){" +
                                                           "divsToHide[i].style.visibility='hidden';}")
        
        gameWebView.stringByEvaluatingJavaScriptFromString("var divsToHide = document.getElementsByClassId('tabs');" +
            "for(var i = 0; i < divsToHide.length; i++){" +
            "divsToHide[i].style.visibility='hidden';}")
    }
    
}

