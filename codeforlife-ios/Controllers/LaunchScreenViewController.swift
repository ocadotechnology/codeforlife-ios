//
//  LoadScreenViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import CoreData

public class LaunchScreenViewController: UIViewController, LoadScreenDelegate {
    
    private static let UPDATE_FINISHED: Int = -1

    @IBOutlet public weak var startButton: UIButton!
    @IBOutlet public weak var progressView: UIProgressView!
    
    var numberOfRequests = 0 {
        didSet {
            numberOfRequestsLeft = numberOfRequests
        }
    }
    
    var numberOfRequestsLeft = 0 {
        didSet {
            if numberOfRequestsLeft == 0 {
                print("Done")
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
    
    var runUpdate = LaunchScreenViewController.UPDATE_FINISHED {
        didSet {
            switch runUpdate {
                case  0: startUpdate()
                case  1: loadEpisodes()
                case  2: loadLevels()
                case  3: loadMaps()
                default: finishUpdate()
            }
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let noUpdateNeeded = Config.fetchResults().count > 0
        
        if noUpdateNeeded {
            print("No updates required")
            runUpdate = LaunchScreenViewController.UPDATE_FINISHED
        } else {
            Config.removeAllEntries()
            Config.createInManagedObjectContext("mockETag")
            Config.save()
            print("Updates required")
            runUpdate++
        }
    }
    
    private func finishUpdate() {
        print("Updates finished.")
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
        LoadEpisodesRequest(viewController: self).execute(nil)
    }
    
    private func loadLevels() {
        print("Loading levels... ")
        Level.removeAllEntries()
        LoadLevelsRequest(viewController: self).execute(nil)
    }
    
    private func loadMaps() {
        print("Loading maps... ")
        CDMap.removeAllEntries()
        let levels = Level.fetchResults()
        numberOfRequests = levels.count
        levels.forEach {
            [unowned self] in
            LoadMapRequest(viewController: self, levelUrl: $0.url, mapUrl: $0.mapUrl).execute(nil)
        }
    }
    
    func updateNumberOfTask(numberOfRequests: Int) {
        self.numberOfRequests = numberOfRequests
    }
    
    func finishedOneTask() {
        self.numberOfRequestsLeft--
    }

}
