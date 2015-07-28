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
    
    var numberOfRequests = 0 {
        didSet {
            numberOfRequestsLeft = numberOfRequests
        }
    }
    
    var numberOfRequestsLeft = 0 {
        didSet {
            if numberOfRequestsLeft == 0 {
                println("Done")
                switch runUpdate {
                case 0: progressView!.progress = 0.0
                case 1: Episode.save(); progressView!.progress = 0.2
                case 2: Level.save(); progressView!.progress = 0.6
                case 3: CDMap.save(); progressView!.progress = 1.0
                default: progressView!.progress = 1.0
                }
                runUpdate++
            } else {
                switch runUpdate {
                case 1: progressView!.progress = 0.2 * (1 - Float(numberOfRequestsLeft)/Float(numberOfRequests))
                case 2: progressView!.progress = 0.2 + 0.4 * (1 - Float(numberOfRequestsLeft)/Float(numberOfRequests))
                case 3: progressView!.progress = 0.6 + 0.4 * (1 - Float(numberOfRequestsLeft)/Float(numberOfRequests))
                default: break
                    
                }
            }
        }
    }
    
    var runUpdate = -1 {
        didSet {
            switch runUpdate {
            case  0: startUpdate()
            case  1: loadEpisodes()
            case  2: loadLevels()
            case  3: loadMaps()
            default: finishUpdate();
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var episodeVersion = 1.01
        var levelVersion = 1.0
        
        let noUpdateNeeded = episodeVersion == 1.0
        
        if noUpdateNeeded {
            println("No updates required")
            runUpdate = -1
        } else {
            println("Updates required")
            runUpdate++   // run Update
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func finishUpdate() {
        println("Updates finished.")
        startButton.enabled = true
        progressView.hidden = true
    }
    
    private func startUpdate() {
        print("Starting Application Update... ")
        startButton.enabled = false
        numberOfRequestsLeft = 0
    }
    
    private func loadEpisodes() {
        print("Loading Episodes... ")
        Episode.removeAllEntries()
        LoadEpisodesRequest(loadScreenviewController: self).execute()
    }
    
    private func loadLevels() {
        print("Loading levels... ")
        Level.removeAllEntries()
        LoadLevelsRequest(loadScreenviewController: self).execute()
    }
    
    private func loadMaps() {
        print("Loading maps... ")
        CDMap.removeAllEntries()
        let levels = Level.fetchResults()
        numberOfRequests = levels.count
        for level in levels {
            LoadMapRequest(loadScreenviewController: self, levelUrl: level.url, mapUrl: level.mapUrl).execute()
        }
    }

}
