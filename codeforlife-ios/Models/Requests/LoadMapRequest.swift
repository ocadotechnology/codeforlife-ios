//
//  LoadMapRequest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 27/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class LoadMapRequest: Request {
    
    let url: String
    let method: Alamofire.Method
    var params: [String: String]
    var mode: Mode
    
    weak var viewController: LoadScreenDelegate?
    var levelUrl: String
    
    init(viewController: LoadScreenDelegate?, levelUrl: String, mapUrl: String) {
        self.url = mapUrl
        self.method = .GET
        self.params = [String: String]()
        self.mode = DefaultMode
        self.viewController = viewController
        self.levelUrl = levelUrl
    }
    
    func execute(callback: (() -> Void)?) {
        switch mode {
        case .Mock:
            LoadMapRequestMockDelegate().execute(processData, callback: callback)
        default:
            APIRequestDelegate(url: url, method: method).execute(processData, callback: callback)
        }
    }
    
    func processData(data: NSData) {
        CDMap.createInManagedObjectContext(levelUrl, jsonData: data)
        viewController?.finishedOneTask()
    }

}
