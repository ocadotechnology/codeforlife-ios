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

protocol LoadScreenDelegate: class {
    func updateNumberOfTask(numberOfTask: Int)
    func finishedOneTask()
}

class LoadEpisodesRequest: Request {
    
    let url: String
    let method: Alamofire.Method
    var params: [String: String]
    var mode: Mode
    
    weak var viewController: LoadScreenDelegate?
    
    let devUrl = "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/episodes/"
    
    init(viewController: LoadScreenDelegate?) {
        self.url = "https://www.codeforlife.education/rapidrouter/api/episodes/"
        self.method = .GET
        self.params = [String: String]()
        self.mode = DefaultMode
        self.viewController = viewController
    }
    
    func execute(callback: (() -> Void)?) {
        switch mode {
        case .Development:
            APIRequestDelegate(url: devUrl, method: method).execute(processData, callback: callback)
        case .Mock:
            LoadEpisodesRequestMockDelegate().execute(processData, callback: callback)
        default:
            APIRequestDelegate(url: url, method: method).execute(processData, callback: callback)
        }
    }
    
    func processData(data: NSData) {
        var index = 1
        let json = JSON(data: data)
        if let episodeArray = json.array {
            viewController?.updateNumberOfTask(episodeArray.count)
            for episode in episodeArray {
                if let name = episode["name"].string,
                        url = episode["url"].string {
                    Episode.createInManagedObjectContext(index++, name: name, url: url)
                    viewController?.finishedOneTask()
                }
            }
        }
    }
}