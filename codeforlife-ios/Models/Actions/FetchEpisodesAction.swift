//
//  FetchEpisodesAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class FetchEpisodesAction : Action, ActionProtocol {
    
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
        self.delegate = FetchEpisodesActionDelegate()
    }
    
    override func processData(data: NSData) {
        
        var episodes = [Episode]()
        
        let json = JSON(data: data)
        if let episodeArray = json.array {
            for episode in episodeArray {
                if let episodeName = episode["name"].string {
                    if let episodeUrl = episode["url"].string {
                        episodes.append(Episode(name: episodeName, url: episodeUrl))
                    }
                }
            }
        }
        
        if let controller = self.viewController as? EpisodeViewController {
            controller.episodes = episodes
        }
        
    }
    
    override func switchToDev() -> Action {
        self.delegate = FetchEpisodesActionDevDelegate()
        return self
    }
    
    override func switchToMock() -> Action {
        self.delegate = FetchEpisodesActionMockDelegate()
        return self
    }
    
    
    
}