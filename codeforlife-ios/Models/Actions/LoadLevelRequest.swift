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
    
    init(loadScreenviewController: LoadScreenViewController, url: String) {
        self.viewController = loadScreenviewController
        super.init(
        devUrl: url,
        delegate: APIRequestDelegate(url: url, method: Alamofire.Method.GET),
        mockDelegate: FetchLevelRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
        let json = JSON(data: data)
        if let name = json["name"].string,
        title = json["title"].string,
        description = json["description"].string,
        hint = json["hint"].string,
        blocklyEnabled = json["blocklyEnabled"].bool,
        pythonEnabled = json["pythonEnabled"].bool,
        pythonViewEnabled = json["pythonViewEnabled"].bool,
        blockSetUrl = json["levelblock_set"].string,
        mapUrl = json["map"].string {
            
            var processedDescription = description
                .stringByReplacingOccurrencesOfString("<br>", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
                .stringByReplacingOccurrencesOfString("<b>", withString: "<", options: NSStringCompareOptions.LiteralSearch, range: nil)
                .stringByReplacingOccurrencesOfString("</b>", withString: ">", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            var processedHint = hint
                .stringByReplacingOccurrencesOfString("<br>", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
                .stringByReplacingOccurrencesOfString("<b>", withString: "<", options: NSStringCompareOptions.LiteralSearch, range: nil)
                .stringByReplacingOccurrencesOfString("</b>", withString: ">", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            XLevel.createInManagedObjectContext(0, level: 0,
                name: name,
                title: title,
                url: "",
                levelDescription: processedDescription,
                hint: processedHint,
                blockSetUrl: blockSetUrl,
                pythonEnabled: pythonEnabled,
                pythonViewEnabled: pythonViewEnabled,
                webViewUrl: "",
                mapUrl: mapUrl)
            viewController.jobRemained--
        }
    }
}

