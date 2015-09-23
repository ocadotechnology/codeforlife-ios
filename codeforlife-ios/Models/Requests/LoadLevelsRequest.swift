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

class LoadLevelsRequest: Request {
    
    let url: String
    let method: Alamofire.Method
    var params: [String: String]
    var mode: Mode
    
    weak var viewController: LoadScreenDelegate?
    
    let devUrl = "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/levels/"
    
    init(viewController: LoadScreenDelegate?) {
        self.viewController = viewController
        self.url = "https://www.codeforlife.education/rapidrouter/api/levels/"
        self.method = .GET
        self.params = [String: String]()
        self.mode = DefaultMode
    }
    
    func execute(callback: (() -> Void)?) {
        switch mode {
        case .Development:
            APIRequestDelegate(url: devUrl, method: method).execute(processData, callback: callback)
        case .Mock:
            LoadLevelsRequestMockDelegate().execute(processData, callback: callback)
        default:
            APIRequestDelegate(url: url, method: method).execute(processData, callback: callback)
        }
    }
    
    func processData(data: NSData) {
        let json = JSON(data: data)
        if let levelArray = json.array {
            viewController?.updateNumberOfTask(levelArray.count)
            var index = 1;
            for level in levelArray {
                if let url = level["url"].string {
                    LoadLevelRequest(level: index++, url: url).execute {
                        [weak viewController] in
                        viewController?.finishedOneTask()
                    }
                }
            }
        }
    }
}