//
//  LoadLevelRequest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class LoadLevelRequest: Request, RequestProtocol {
    
    unowned var viewController: LoadScreenViewController
    var level: Int
    var url: String
    
    init(loadScreenviewController: LoadScreenViewController, level: Int, url: String) {
        self.viewController = loadScreenviewController
        self.level = level
        self.url = url
        super.init(
        devUrl: url,
        delegate: APIRequestDelegate(url: url, method: Alamofire.Method.GET),
        mockDelegate: FetchLevelRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
        let json = JSON(data: data)
        if let name = json["name"].string,
                title = json["title"].string,
                episodeUrl = json["episode"].string,
                description = json["description"].string,
                hint = json["hint"].string,
                blocklyEnabled = json["blocklyEnabled"].bool,
                pythonEnabled = json["pythonEnabled"].bool,
                pythonViewEnabled = json["pythonViewEnabled"].bool,
                blockSetUrl = json["levelblock_set"].string,
                mapUrl = json["map"].string {
            
            let processedDescription = description.removedHtmlTag()
            let processedHint = hint.removedHtmlTag()
            let nextLevelUrl = json["next_level"].string ?? ""
                    
            Level.createInManagedObjectContext(episodeUrl,
                                                level: level,
                                                name: name,
                                                title: title,
                                                url: url,
                                                levelDescription: processedDescription,
                                                hint: processedHint,
                                                blockSetUrl: blockSetUrl,
                                                blocklyEnabled: blocklyEnabled,
                                                pythonEnabled: pythonEnabled,
                                                pythonViewEnabled: pythonViewEnabled,
                                                webViewUrl: kCFLDomain + kCFLRapidRouter + name + "/?mode=ios",
                                                mapUrl: mapUrl,
                                                nextLevelUrl: nextLevelUrl)
        }
    }
    
}

