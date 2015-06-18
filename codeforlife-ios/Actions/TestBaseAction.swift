//
//  TestBaseAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class TestBaseAction: BaseAction {
    
    init() {
        super.init(url: "https://api.github.com/users/joeyynchan", httpMethod: "GET")
    }
    
}