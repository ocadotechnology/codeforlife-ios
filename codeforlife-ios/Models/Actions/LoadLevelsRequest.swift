//
//  LoadLevelsRequest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class LoadLevelsRequest: Request, RequestProtocol {
    
    unowned var viewController: LoadScreenViewController
    
    init(loadScreenviewController: LoadScreenViewController, url: String) {
        self.viewController = loadScreenviewController
        super.init(
            devUrl: url,
            delegate: APIRequestDelegate(url: url, method: Alamofire.Method.GET),
            mockDelegate: FetchLevelsRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
        var levels = [Level]()
        let json = JSON(data: data)
        if let levelArray = json["level_set"].array {
            for level in levelArray {
                if let url = level["url"].string {
                    viewController.jobRemained++
                    LoadLevelRequest(loadScreenviewController: viewController, url: url).execute()
                }
            }
        }
    }
}