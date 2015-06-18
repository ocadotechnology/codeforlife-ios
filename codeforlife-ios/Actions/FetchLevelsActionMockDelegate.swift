//
//  FetchLevelsActionMockDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class FetchLevelsActionMockDelegate: ActionDelegate, ActionDelegateProtocol
{
    override func execute(request: NSMutableURLRequest, processData: (NSDictionary -> Void)) {
        var data = NSDictionary()
        processData(data)
    }
}