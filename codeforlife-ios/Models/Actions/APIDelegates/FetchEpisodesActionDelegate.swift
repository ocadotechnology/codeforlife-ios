//
//  FetchEpisodesActionDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FetchEpisodesActionDelegate: APIActionDelegate {
    
    override init() {
        super.init()
        url = ""
        method = Alamofire.Method.GET
    }
    
}
