//
//  LoadBlockSetRequest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class LoadBlockSetRequest: Request, RequestProtocol {
    
    unowned var viewController: LoadScreenViewController
    var levelUrl: String
    var blockSetUrl: String
    
    init(loadScreenViewController: LoadScreenViewController, levelUrl: String, blockSetUrl: String) {
        self.viewController = loadScreenViewController
        self.levelUrl = levelUrl
        self.blockSetUrl = blockSetUrl
        super.init(
        devUrl: blockSetUrl,
        delegate: APIRequestDelegate(url: blockSetUrl, method: Alamofire.Method.GET),
        mockDelegate: FetchBlockSetRequestMockDelegate())
    }
    
    
}