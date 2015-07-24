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
    let url = ""
    
    init(loadScreenviewController: LoadScreenViewController) {
        self.viewController = loadScreenviewController
        super.init(
            devUrl: "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/levels/",
            delegate: APIRequestDelegate(url: url, method: Alamofire.Method.GET),
            mockDelegate: FetchLevelsRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
        var levels = [Level]()
        let json = JSON(data: data)
        if let levelArray = json.array {
            viewController.numberOfRequestLeft = levelArray.count
            var index = 1;
            for level in levelArray {
                if let url = level["url"].string {
                    LoadLevelRequest(loadScreenviewController: viewController,level: index++, url: url).execute {
                        [unowned viewController] in
                        viewController.numberOfRequestLeft--
                    }
                }
            }
        }
    }
}