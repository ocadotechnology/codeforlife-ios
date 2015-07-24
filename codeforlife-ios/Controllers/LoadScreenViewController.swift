//
//  LoadScreenViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import CoreData

class LoadScreenViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    let maxNumberOfJobs = 109
    var jobRemained = 0 {
        didSet {
            progressView.progress = Float(1 - Float(jobRemained)/Float(maxNumberOfJobs))
            println((jobRemained/maxNumberOfJobs, progressView.progress))
            startButton.enabled = jobRemained == 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.enabled = false
        LoadEpisodesRequest().execute(callback: {
            for result in XEpisode.fetchResults() {
                LoadLevelsRequest(loadScreenviewController: self, url: result.url).execute()
            }
        })
        
        // Do any additional setup after loading the view.
    }

}
