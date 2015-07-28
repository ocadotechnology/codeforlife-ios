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

class LoadMapRequest: Request, RequestProtocol {
    
    unowned var viewController: LoadScreenViewController
    var levelUrl: String
    var mapUrl: String
    
    init(loadScreenviewController: LoadScreenViewController, levelUrl: String, mapUrl: String) {
        self.viewController = loadScreenviewController
        self.levelUrl = levelUrl
        self.mapUrl = mapUrl
        super.init(
            devUrl: mapUrl,
            delegate: APIRequestDelegate(url: mapUrl, method: Alamofire.Method.GET),
            mockDelegate: FetchLevelRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
        CDMap.createInManagedObjectContext(levelUrl, jsonData: data)
        viewController.numberOfRequestsLeft--
    }

}
