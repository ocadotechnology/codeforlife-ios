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

class LoadLevelRequest: Request {
    
    let url: String
    let method: Alamofire.Method
    var params: [String: String]
    var mode: Mode
    
    let level: Int
    
    init(level: Int, url: String) {
        self.url = url
        self.method = .GET
        self.params = [String: String]()
        self.mode = DefaultMode
        self.level = level
    }
    
    func execute(callback: (() -> Void)?) {
        switch mode {
        case .Mock:
            LoadLevelRequestMockDelegate().execute(processData, callback: callback)
        default:
            APIRequestDelegate(url: url, method: method).execute(processData, callback: callback)
        }
    }
    
    func processData(data: NSData) {
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

