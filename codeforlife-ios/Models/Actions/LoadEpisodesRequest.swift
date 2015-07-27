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

class LoadEpisodesRequest: Request, RequestProtocol {
    
    unowned var viewController: LoadScreenViewController
    let url = ""
    
    init(loadScreenviewController: LoadScreenViewController) {
        self.viewController = loadScreenviewController
        super.init(
            devUrl: "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/episodes/",
            delegate: APIRequestDelegate(url: url, method: Alamofire.Method.GET),
            mockDelegate: FetchLevelsRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
        var index = 1
        let json = JSON(data: data)
        if let episodeArray = json.array {
            viewController.numberOfRequestLeft = episodeArray.count
            for episode in episodeArray {
                if let name = episode["name"].string,
                        url = episode["url"].string {
                    Episode.createInManagedObjectContext(index++, name: name, url: url)
                    viewController.numberOfRequestLeft--
                }
            }
        }
    }
}