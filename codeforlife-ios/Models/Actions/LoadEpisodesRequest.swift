//
//  LoadEpisodesRequest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class LoadEpisodesRequest: FetchEpisodesRequest {
    
    init() {
        super.init(EpisodeViewController())
    }
    
    override func processData(data: NSData) {
        var index = 1
        var episodes = [Episode]()
        let json = JSON(data: data)
        if let episodeArray = json.array {
            for episode in episodeArray {
                if let name = episode["name"].string,
                        url = episode["url"].string {
                    XEpisode.createInManagedObjectContext(index++, name: name, url: url)
                }
            }
        }
    }
}