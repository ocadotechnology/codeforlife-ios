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
    
    let url = "Insert Actual API URL"
    
    unowned var viewController: EpisodeViewController
    
    init(_ viewController: EpisodeViewController) {
        self.viewController = viewController
        super.init(
            devUrl: "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/episodes/",
            delegate: APIActionDelegate(url: url, method: Alamofire.Method.GET),
            mockDelegate: FetchEpisodesActionMockDelegate())
    }
    
    override func processData(data: NSData) {
        var episodes = [Episode]()
        let json = JSON(data: data)
        if let episodeArray = json.array {
            for episode in episodeArray {
                if let episodeName = episode["name"].string {
                    if let episodeUrl = episode["url"].string {
                        var newEpisode = Episode(name: episodeName, url: episodeUrl)
                        episodes.last?.nextEpisode = newEpisode
                        newEpisode.prevEpisode = episodes.last
                        episodes.append(newEpisode)
                    }
                }
            }
        }
        viewController.episodes = episodes
    }
    
//    deinit { println("FetchEpisodesAction is being deallocated") }
    
}