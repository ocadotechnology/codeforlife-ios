//
//  APIActionDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FetchLevelsActionDelegate : APIActionDelegate {
    
    init(url: String) {
        super.init()
        self.url = url
        self.method = Alamofire.Method.GET
    }
    
}
