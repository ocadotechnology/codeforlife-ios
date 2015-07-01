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
    
    let url = ""
    let devUrl = "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/episodes/"
    
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init(delegate: APIActionDelegate(url: url, method: Alamofire.Method.GET))
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
        self.delegate = APIActionDelegate(url: devUrl, method: Alamofire.Method.GET)
        return self
    }
    
    override func switchToMock() -> Action {
        self.delegate = FetchEpisodesActionMockDelegate()
        return self
    }
    
    
    
}